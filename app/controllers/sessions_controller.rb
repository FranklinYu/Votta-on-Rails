# frozen_string_literal: true

# @restful_api 1.0
class SessionsController < ApplicationController
  before_action :authenticate, except: [:create]
  before_action :set_session, except: [:index, :create]

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
  #       {"id": 3, "comment": "my Mac"},
  #       {"id": 5, "comment": "my iPhone"}
  #     ]
  #   }
  #   ```
  def index
    @sessions = @current_session.user.sessions
  end

  # @url /sessions
  # @action POST
  #
  # Log in as a registered user.
  #
  # @required [String] email
  # @required [String] password Plaintext password
  # @optional [String] session[comment] comment to identify the session
  #
  # @response a token
  #
  # @example_request
  #   ```form
  #   email=registered_user@example.com
  #   password=p1aint3xt-pa55w0rd
  #   session[comment]=foo bar
  #   ```
  #
  # @example_response
  #   ```json
  #   {
  #     "token": "abc"
  #   }
  #   ```
  def create
    @user = User.find_by_email(params[:email])
    if @user.nil?
      @error = {email: "no user with email: #{params[:email]}"}
      return render status: :not_found
    end

    default_comment_to_user_agent

    @user = @user.authenticate(params[:password])
    if @user
      @token = @user.sessions.create(session_params).id
      render status: :created
    else
      @error = {password: 'not match'}
      render status: :unprocessable_entity
    end
  end

  private def default_comment_to_user_agent
    params[:session] ||= {}
    b = Browser.new(request.user_agent)
    if (b.known?)
      params[:session][:comment] ||= "#{b.name} #{b.full_version} on #{b.platform.name} #{b.platform.version}"
    else
      params[:session][:comment] ||= request.user_agent
    end
  end

  # @url /sessions/:id
  # @action PATCH
  #
  # Update the information of the session.
  #
  # @optional [String] comment Comment of the session.
  #
  # @response [Session] the new session details
  #
  # @example_request
  #   ```form
  #   session[comment]=my iMac
  #   ```
  #
  # @example_response
  #   ```json
  #   {
  #     "id": 5,
  #     "comment": "my iMac"
  #   }
  #   ```
  def update
    if @session.user == @current_session.user
      @session.update!(session_params)
    else
      render plain: 'Not your session.', status: :unauthorized
    end
  end

  # @url /sessions/:id
  # @action DELETE
  #
  # Log out the session.
  def destroy
    if @session.user == @current_session.user
      @session.destroy!
    else
      render plain: 'Not your session.', status: :unauthorized
    end
  end

  private def session_params
    params.require_or_empty(:session).permit(:comment)
  end

  private def set_session
    @session = Session.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    head :not_found
  end
end
