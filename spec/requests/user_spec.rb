# frozen_string_literal: true

require 'rails_helper'
require 'support/logged_in_user'

describe 'User resource' do
  describe '#create' do
    it 'creates an account' do
      post user_path, params: {email: 'new_user@example.com', password: 'pass-pass'}
      expect(response).to be_ok
      user = User.find_by_email('new_user@example.com')
      expect(user).not_to be_falsey
      expect(user.authenticate('pass-pass')).not_to be_falsey
    end

    it 'rejects request with duplicated email' do
      create(:user, email: 'current_user@example.com', password: 'old password')
      post user_path, params: {email: 'current_user@example.com', password: 'new password'}
      expect(response).to be_bad_request
      expect(response.parsed_body.with_indifferent_access).to include(
        error: a_hash_including(
          email: a_collection_including(
            a_kind_of(String)
          )
        )
      )
    end

    it 'rejects request with too short a password' do
      post user_path, params: {email: 'user@example.com', password: 'short'}
      expect(response).to be_bad_request
      expect(response.parsed_body.with_indifferent_access).to include(
        error: a_hash_including(
          password: a_collection_including(
            a_string_including('short', '8')
          )
        )
      )
    end
  end

  context 'when logged in' do
    let(:current_session) do
      user = create(:user, email: 'current_user@example.com')
      create(:session, user: user)
    end

    describe '#show' do
      it 'shows an account' do
        get user_path
        expect(response).to be_ok
        expect(response.parsed_body.with_indifferent_access).to include(:email)
      end
    end

    describe '#update' do
      it 'updates an account' do
        patch user_path, params: {email: 'new_email@example.com', password: 'my-new-password'}
        expect(response).to be_ok
        expect(response.parsed_body.with_indifferent_access).to include(
          email: 'new_email@example.com',
          password_updated: true
        )
      end

      it 'rejects to update if email exists' do
        create(:user, email: 'collision@example.com')
        patch user_path, params: {email: 'collision@example.com'}
        expect(response).to be_bad_request
        expect(response.parsed_body.with_indifferent_access).to include(
          error: a_hash_including(:email)
        )
      end

      it 'rejects to update if new password is too short' do
        patch user_path, params: {password: 'short'}
        expect(response).to be_bad_request
        expect(response.parsed_body.with_indifferent_access).to include(
          error: a_hash_including(:password)
        )
      end
    end

    describe '#destroy' do
      it 'destroys an account along with its sessions' do
        user = current_session.user
        another_session = current_session.user.sessions.create
        delete user_path
        expect(response).to be_ok
        expect { user.reload }.to raise_error(ActiveRecord::RecordNotFound)
        expect { current_session.reload }.to raise_error(ActiveRecord::RecordNotFound)
        expect { another_session.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
