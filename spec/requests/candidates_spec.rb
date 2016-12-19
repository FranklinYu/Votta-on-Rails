# frozen_string_literal: true

require 'rails_helper'
require 'support/logged_in_user'

RSpec.describe 'Candidate resource', type: :request do
  let(:current_session) { create(:session) }
  let(:candidate) { create(:candidate) }

  context 'when upvoted' do
    before(:example) do
      create(:vote, candidate: candidate, user: current_session.user)
    end

    it 'cannot be up-voted again' do
      post vote_up_candidate_path(candidate)
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'allows users to cancel their votes' do
      delete vote_up_candidate_path(candidate)
      expect(response).to have_http_status(:ok)
    end
  end

  context 'when not upvoted' do
    it 'can be up-voted' do
      post vote_up_candidate_path(candidate)
      expect(response).to have_http_status(:created)
    end

    it 'does not allow invalid cancellation' do
      delete vote_up_candidate_path(candidate)
      expect(response).to have_http_status(:not_found)
    end
  end
end
