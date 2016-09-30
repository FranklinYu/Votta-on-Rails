# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Topic, type: :model do
  it 'is not destroyed when the creator is destroyed' do
    topic = create(:topic)
    topic.user.destroy!
    expect { topic.reload }.not_to raise_error
    expect(topic.user).to be_nil
  end
end
