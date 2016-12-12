# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Candidate do
  it 'is destroyed with its topic' do
    candidate = create(:candidate)
    candidate.topic.destroy!
    expect { candidate.reload }.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'is not destroyed with its user' do
    candidate = create(:candidate)
    candidate.user.destroy!
    expect { candidate.reload }.not_to raise_error
    expect(candidate.user).to be_nil
  end

  it 'requires non-empty body' do
    expect { create(:candidate, body: '') }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
