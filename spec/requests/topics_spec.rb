# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Topics resources', type: :request do
  describe "GET /topics" do
    it "works! (now write some real specs)" do
      get topics_path
      expect(response).to have_http_status(200)
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
  end
end
