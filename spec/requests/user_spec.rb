# frozen_string_literal: true

require 'rails_helper'

describe 'User resource' do
  describe '#create' do
    it 'creates an account' do
      post user_path
      expect(response).to be_ok
    end
  end

  describe '#show' do
    it 'shows an account' do
      get user_path
      expect(response).to be_ok
    end
  end

  describe '#update' do
    it 'updates an account' do
      patch user_path
      expect(response).to be_ok
    end
  end

  describe '#destroy' do
    it 'destroys an account' do
      delete user_path
      expect(response).to be_ok
    end
  end
end
