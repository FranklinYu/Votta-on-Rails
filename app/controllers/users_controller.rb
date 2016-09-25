# frozen_string_literal: true

# @restful_api 1.0
class UsersController < ApplicationController
  before_action :authenticate, except: [:create]

  # @url /user
  # @action POST
  #
  # Register a user.
  #
  # @required [String] email
  # @required [String] password 8 characters minimal
  #
  # @response an empty object
  #
  # @example_request
  #   ```form
  #   email=new_user@example.com
  #   password=p1aint3xt-pa55w0rd
  #   ```
  # @example_response
  #   ```json
  #   {}
  #   ```
  def create
    User.create!(params.permit(:email, :password))
  rescue ActiveRecord::RecordInvalid => e
    @error = e.record.errors
    render status: :bad_request
  end

  # @url /user
  # @action GET
  #
  # Show the information for the current logged in user.
  #
  # @response [User] the current user
  #
  # @example_request
  #   (no parameters)
  #
  # @example_response
  #   ```json
  #   {
  #     "email": "current_user@example.com"
  #   }
  #   ```
  def show
    @user = @current_session.user
  end

  def update; end
  def destroy; end
end
