# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  let(:user) { create(:user, email: 'user@example.com', password: 'myPassword') }

  it 'accepts correct password' do
    expect(user.authenticate('myPassword')).to be(user)
  end

  it 'rejects incorrect password' do
    expect(user.authenticate('wrongPassword')).to be(false)
  end

  it 'verifies existance of password on create' do
    expect { create(:user, password: '') }.to raise_error(ActiveRecord::RecordInvalid) do |error|
      expect(error.record.errors.details).to include(
        password: a_collection_including(
          a_hash_including(error: :blank)
        )
      )
    end
  end

  it 'does not require password to be updated on every update' do
    expect { user.update!(email: 'new@example.com') }.not_to raise_error
  end
end
