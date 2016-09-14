# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :authenticate, except: [:create]

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

  def index; end
  def update; end
  def destroy; end
end
