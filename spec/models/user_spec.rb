# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  let(:user) { create(:user, password: 'myPassword') }

  it 'accepts correct password' do
    expect(user.authenticate('myPassword')).to be(user)
  end

  it 'rejects incorrect password' do
    expect(user.authenticate('wrongPassword')).to be(false)
  end
end
