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
      user = create(:user, email: 'current_user@example.com', password: 'old password')
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
    let(:current_session) { create(:session) }

    describe '#show' do
      it 'shows an account' do
        get user_path
        expect(response).to be_ok
      end
    end

    describe '#update' do
      it 'updates an account' do
        patch user_path
        expect(response).to be_ok
      end
    end

    describe '#destroy' do
      it 'destroys an account' do
        delete user_path
        expect(response).to be_ok
      end
    end
  end
end
