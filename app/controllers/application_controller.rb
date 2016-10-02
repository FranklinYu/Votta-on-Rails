# frozen_string_literal: true

class ActionController::Parameters
  # Same as `#require`, but will return empty parameter instead of throwing errors.
  def require_or_empty(key)
    return key.map { |k| require_or_empty(k) } if key.is_a?(Array)
    require(key)
  rescue ActionController::ParameterMissing
    self.class.new
  end
end

class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  protected def authenticate
    authenticate_or_request_with_http_token do |token|
      begin
        # TODO: use stronger token than `session_id`
        @current_session = Session.find(token)
      rescue ActiveRecord::RecordNotFound
        false
      end
    end
  end
end
