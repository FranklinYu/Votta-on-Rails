# frozen_string_literal: true

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
