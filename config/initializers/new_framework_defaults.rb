# frozen_string_literal: true

# Be sure to restart your server when you modify this file.
#
# This file contains migration options to ease your Rails 5.0 upgrade.
#
# Read the Rails 5.0 release notes for more info on each option.

# Make Ruby 2.4 preserve the timezone of the receiver when calling `to_time`.
# Previous versions had false.
ActiveSupport.to_time_preserves_timezone = true

# Require `belongs_to` associations by default. Previous versions had false.
Rails.application.config.active_record.belongs_to_required_by_default = true

# Do not halt callback chains when a callback returns false. Previous versions had true.
ActiveSupport.halt_callback_chains_on_return_false = false

# Configure SSL options to enable HSTS with subdomains. Previous versions had false.
Rails.application.config.ssl_options = { hsts: { subdomains: true } }

# If false, `FooController` only includes module FooHelper from `app/helpers/foo_helper.rb`,
# instead of all the helpers in `app/helpers/` directory.
# `BarHelper` can be manually included in `FooController` with the help of [`helper` method][1].
# Previous versions had false.
#
# [1]: http://api.rubyonrails.org/v5.0.0.1/classes/AbstractController/Helpers/ClassMethods.html#method-i-helper
Rails.application.config.action_controller.include_all_helpers = false
