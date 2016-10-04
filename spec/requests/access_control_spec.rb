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
    subject.call(headers: {authorization: "Token #{invalid_session_id}"})
    expect(response).to have_http_status(:unauthorized)
  end

  it 'is accessible with valid token' do
    subject.call(headers: {authorization: "Token #{session.id}"})
    expect(response).to have_http_status(:ok)
  end
end

describe 'access control' do
  describe 'Sessions resource' do
    describe '#index' do
      subject { proc { |*options| get sessions_path, *options} }
      include_examples 'resource requiring authorization'
    end

    describe '#update' do
      subject { proc { |*options| patch session_path(session), *options } }
      include_examples 'resource requiring authorization'
    end

    describe '#destroy' do
      subject { proc { |*options| delete session_path(session), *options } }
      include_examples 'resource requiring authorization'
    end
  end

  describe 'User resource' do
    describe '#show' do
      subject { proc { |*options| get user_path, *options } }
      include_examples 'resource requiring authorization'
    end

    describe '#update' do
      subject { proc { |*options| patch user_path, *options } }
      include_examples 'resource requiring authorization'
    end

    describe '#destroy' do
      subject { proc { |*options| delete user_path, *options } }
      include_examples 'resource requiring authorization'
    end
  end
end
