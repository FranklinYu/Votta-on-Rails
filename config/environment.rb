# frozen_string_literal: true

# this is required by `./secrets.yml`
if Rails.application.secrets.secret_key_base.nil?
  raise 'secret key base not found; specify it in `config/secrets.yml`'
end

# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
