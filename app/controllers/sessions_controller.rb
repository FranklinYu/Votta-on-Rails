# frozen_string_literal: true

# @restful_api 1.0
class SessionsController < ApplicationController
  before_action :authenticate, except: [:create]

  # @url /sessions
  # @action GET
  #
  # List all the sessions for the current user.
  #
  # @response [Array<Session>]
  #
  # @example_request (with authentication header)
  #
  # @example_response
  #   ```json
  #   {
  #     "sessions": [
  #       {"comment": "my Mac"},
  #       {"comment": "my iPhone"}
  #     ]
  #   }
  #   ```
  def index
    @sessions = @session.user.sessions
  end

  # @url /sessions
  # @action POST
  #
  # Log in as a registered user.
  #
  # @required [String] email
  # @required [String] password Plaintext password
  #
  # @response a token
  #
  # @example_request
  #   ```form
  #   email=registered_user@example.com
  #   password=p1aint3xt-pa55w0rd
  #   ```
  #
  # @example_response
  #   ```json
  #   {
  #     "token": "abc"
  #   }
  #   ```
  def create
    user = User.find_by_email(params[:email])
    if user.nil?
      @error = {email: "no user with email: #{params[:email]}"}
      return render status: :not_found
    end
    user = user.authenticate(params[:password])
    if user
      @token = user.sessions.create.id
    else
      @error = {password: 'not match'}
      render status: :unprocessable_entity
    end
  end

  def update; end
  def destroy; end
end
