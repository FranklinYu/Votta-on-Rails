# frozen_string_literal: true

require 'rails_helper'

shared_examples 'resource requiring authorization' do
  let(:session) { create(:session) }

  it 'is inaccessible without token' do
    subject.call
    expect(response).to be_unauthorized
  end

  it 'is inaccessible with invalid token' do
    invalid_session_id = Session.count + 2
    subject.call(headers: {authorization: "Token #{invalid_session_id}"})
    expect(response).to be_unauthorized
  end

  it 'is accessible with valid token' do
    subject.call(headers: {authorization: "Token #{session.id}"})
    expect(response).to be_ok
  end
end

describe 'access control' do
  describe 'Sessions resource' do
    describe '#index' do
      subject { Proc.new { |*options| get sessions_path, *options} }
      include_examples 'resource requiring authorization'
    end

    describe '#update' do
      subject { Proc.new { |*options| patch session_path(session), *options } }
      include_examples 'resource requiring authorization'
    end

    describe '#destroy' do
      subject { Proc.new { |*options| delete session_path(session), *options } }
      include_examples 'resource requiring authorization'
    end
  end
end
