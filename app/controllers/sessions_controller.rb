# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :authenticate, except: [:create]

  def index; end
  def update; end
  def destroy; end
end
