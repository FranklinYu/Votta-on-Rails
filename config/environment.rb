# frozen_string_literal: true

# this is required by `./secrets.yml`
raise 'secret key base not found' unless ENV['SECRET_KEY_BASE']

# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
