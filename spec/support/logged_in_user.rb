# frozen_string_literal: true

module LoggedInUser
  extend ActiveSupport::Concern

  included do
    let(:current_session) { nil }
    prepend RequestHelpersCustomized
  end

  module RequestHelpersCustomized
    lambda = lambda do |path, **kwarg|
      unless current_session.nil?
        kwarg[:headers] = {authorization: "Token #{current_session.id}"}.merge(kwarg[:headers] || {})
      end
      super(path, **kwarg)
    end
    %w(get post patch put delete).each do |method|
      define_method method, lambda
    end
  end
end

RSpec.configure do |config|
  config.include(LoggedInUser, type: :request)
end
