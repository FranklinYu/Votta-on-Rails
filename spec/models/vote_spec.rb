require 'rails_helper'

RSpec.describe Vote, type: :model do
  let(:vote) { create(:vote) }

  it 'is unique for a candidate and a user' do
    expect do
      Vote.create!(user: vote.user, candidate: vote.candidate)
    end.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'allows same user for different candidate' do
    user = create(:user)
    expect do
      Vote.create!(user: user, candidate: vote.candidate)
    end.not_to raise_error
  end

  it 'allows for same candidate from different user' do
    candidate = create(:candidate, topic: vote.candidate.topic)
    expect do
      Vote.create!(user: vote.user, candidate: candidate)
    end.not_to raise_error
  end
end
