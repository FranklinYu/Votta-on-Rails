# frozen_string_literal: true

require 'rails_helper'

shared_examples 'resource requiring authorization' do
  let(:session) { create(:session) }

  it 'is inaccessible without token' do
    subject.call
    expect(response).to have_http_status(:unauthorized)
  end

  it 'is inaccessible with invalid token' do
    invalid_session_id = Session.count + 2
    subject.call(authorization: "Token #{invalid_session_id}")
    expect(response).to have_http_status(:unauthorized)
  end

  it 'is accessible with valid token' do
    subject.call(authorization: "Token #{session.id}")
    expect(response).to have_http_status(:success)
  end
end

describe 'access control' do
  describe 'Sessions resource' do
    describe '#index' do
      subject { proc { |hs| get sessions_path, headers: hs } }
      include_examples 'resource requiring authorization'
    end

    describe '#update' do
      subject { proc { |hs| patch session_path(session), headers: hs } }
      include_examples 'resource requiring authorization'
    end

    describe '#destroy' do
      subject { proc { |hs| delete session_path(session), headers: hs } }
      include_examples 'resource requiring authorization'
    end
  end

  describe 'User resource' do
    describe '#show' do
      subject { proc { |hs| get user_path, headers: hs } }
      include_examples 'resource requiring authorization'
    end

    describe '#update' do
      subject { proc { |hs| patch user_path, headers: hs } }
      include_examples 'resource requiring authorization'
    end

    describe '#destroy' do
      subject { proc { |hs| delete user_path, headers: hs } }
      include_examples 'resource requiring authorization'
    end
  end

  describe 'Topics resource' do
    describe '#create' do
      subject { proc { |hs| post topics_path, params: {topic: {title: 'my topic'}}, headers: hs } }
      include_examples 'resource requiring authorization'
    end

    describe '#update' do
      before(:context) { create(:topic) }
      subject { proc { |hs| patch topic_path(Topic.first!), headers: hs } }
      include_examples 'resource requiring authorization'
    end

    describe '#destroy' do
      before(:example) { create(:topic) }
      subject { proc { |hs| delete topic_path(Topic.first!), headers: hs } }
      include_examples 'resource requiring authorization'
    end
  end

  describe 'Candidates resource' do
    describe '#create' do
      subject { proc { |hs| post candidates_path, params: {candidate: {body: 'my two cents', topic_id: 1}}, headers: hs } }
      include_examples 'resource requiring authorization'
    end

    describe '#update' do
      before(:context) { create(:candidate) }
      subject { proc { |hs| patch candidate_path(Candidate.first!), headers: hs } }
      include_examples 'resource requiring authorization'
    end

    describe '#destroy' do
      before(:example) { create(:candidate) }
      subject { proc { |hs| delete candidate_path(Candidate.first!), headers: hs } }
      include_examples 'resource requiring authorization'
    end
  end
end
