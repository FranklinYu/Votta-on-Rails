# frozen_string_literal: true

require 'rails_helper'
require 'support/logged_in_user'

describe 'Sessions resource' do
  describe '#create' do
    let(:user) { create(:user, password: 'correct password') }

    it 'fails with email not registered' do
      post sessions_path, params: {email: 'not-registered@example.com'}
      expect(response).to be_not_found
      expect(response.parsed_body.with_indifferent_access).to include(
        error: a_hash_including(
          email: a_string_including('not-registered@example.com')
        )
      )
    end

    it 'fails with wrong password' do
      post sessions_path, params: {email: user.email, password: 'wrong password'}
      expect(response).to be_unprocessable
      expect(response.parsed_body.with_indifferent_access).to include(
        error: a_hash_including(
          password: a_kind_of(String)
        )
      )
      expect(response.body).to include('password')
    end

    it 'returns usable token' do
      post sessions_path, params: {email: user.email, password: 'correct password'}
      expect(response).to be_ok
      expect(response.parsed_body.with_indifferent_access).to include(:token)
      token = response.parsed_body['token']
      get sessions_path, headers: {authorization: "Token #{token}"}
      expect(response).to be_ok
    end
  end

  context 'when user is logged in' do
    let(:current_session) { create(:session) }

    describe '#index' do
      it 'list all the sessions for current user' do
        another_session = create(:session, user: current_session.user)
        get sessions_path
        expect(response).to be_ok
        expect(response.parsed_body.with_indifferent_access).to include(
          sessions: a_collection_including(
            {comment: current_session.comment},
            {comment: another_session.comment}
          )
        )
      end

      it 'does not leak sessions for other users' do
        another_session = create(:session)
        get sessions_path
        expect(response).to be_ok
        expect(response.parsed_body.with_indifferent_access).not_to include(
          sessions: a_collection_including(
            {comment: another_session.comment}
          )
        )
      end
    end
  end
end
