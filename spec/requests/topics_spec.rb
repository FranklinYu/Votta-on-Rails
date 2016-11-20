# frozen_string_literal: true

require 'rails_helper'
require 'support/logged_in_user'

RSpec.describe 'Topics resources', type: :request do
  describe '#index' do
    it 'lists all the topics' do
      create(:topic, title: 'First', body: 'Your first choice?')
      create(:topic, title: 'Second', body: 'Your second choice?')
      get topics_path
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body.with_indifferent_access).to include(
        a_hash_including(
            title: 'First',
            body: 'Your first choice?'
        ),
        a_hash_including(
          title: 'Second',
          body: 'Your second choice?'
        )
      )
    end
  end

  describe '#show' do
    it 'refuses to show invalid topic' do
      topic = create(:topic)
      path = topic_path(topic)
      topic.destroy!
      get path
      expect(response).to be_not_found
    end

    it 'shows topic' do
      topic = create(:topic, title: 'Best Ice-Scream Scoop', body: 'Choose it!')
      get topic_path(topic)
      expect(response.parsed_body.with_indifferent_access).to include(
        title: 'Best Ice-Scream Scoop',
        body: 'Choose it!'
      )
    end
  end

  describe '#create' do
    let(:current_session) { create(:session) }

    it 'creates a topic' do
      params = {topic: {title: 'new topic'}}
      expect { post topics_path, params: params }.to change { Topic.count }.by(1)
      expect(response).to have_http_status(:created)
    end

    it 'refuses to create topic without title' do
      post topics_path
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.parsed_body.with_indifferent_access).to include(
        error: a_hash_including(:title)
      )
    end
  end
end
