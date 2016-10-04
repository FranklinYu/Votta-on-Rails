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
    render status: :created
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

  # @url /user
  # @action PATCH
  #
  # Update user information.
  #
  # @optional [String] email
  #
  # @response [User] the updated user
  #
  # @example_request_description
  #   normal request
  # @example_request
  #   ```form
  #   email=new_email@example.com
  #   ```
  # @example_response
  #   ```json
  #   {
  #     "email": "new_email@example.com",
  #     "password_updated": false
  #   }
  #   ```
  #
  # @example_request_description
  #   invalid request
  # @example_request
  #   ```form
  #   email=duplicated@example.com
  #   ```
  # @example_response
  #   ```json
  #   {
  #     "error": {
  #       "email": [
  #         "has already been taken"
  #       ]
  #     }
  #   }
  #   ```
  def update
    @user = @current_session.user
    password_digest_cache = @user.password_digest
    if @user.update(params.permit(:email, :password))
      @password_updated = password_digest_cache != @user.password_digest
    else
      @error = @user.errors
      render status: :bad_request
    end
  end

  # @url /user
  # @action DELETE
  #
  # Delete the user. Note that all related information will be lost permanently.
  def destroy
    @current_session.user.destroy!
  end
end
