require 'rails_helper'

RSpec.describe User do
  let(:user) { User.create!(email: 'new-user@example.com', password: 'myPassword') }

  it 'accepts correct password' do
    expect(user.authenticate('myPassword')).to be user
  end

  it 'rejects incorrect password' do
    expect(user.authenticate('wrongPassword')).to be false
  end
end
