# frozen_string_literal: true

# @restful_api 1.0
class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :update, :destroy]
  before_action :authenticate, except: [:index, :show]

  # @url /topics
  # @action GET
  #
  # List all the topics.
  #
  # @example_request (empty request)
  # @example_response
  #   ```json
  #   [
  #     {
  #       "id": 3,
  #       "title": "Favorite Editor",
  #       "body": "What's your favorite editor?"
  #     },
  #     {
  #       "id": 5,
  #       "title": "Favorite Cat",
  #       "body": "What kind of cat do you like most?"
  #     }
  #   ]
  #   ```
  def index
    @topics = Topic.all
  end

  # @url /topics/:id
  # @action GET
  #
  # Show the topic.
  #
  # @response [Topic]
  #
  # @example_request (empty request)
  # @example_response
  #   ```json
  #   {
  #     "title": "Favorite Editor",
  #     "body": "What's your favorite editor?\nThis is important."
  #   }
  #   ```
  def show
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = @current_session.user.topics.new(topic_params)

    if @topic.save
      render :show, status: :created, location: @topic
    else
      render json: @topic.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    if @topic.update(topic_params)
      render :show, status: :ok, location: @topic
    else
      render json: @topic.errors, status: :unprocessable_entity
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.destroy
  end

  # Use callbacks to share common setup or constraints between actions.
  private def set_topic
    @topic = Topic.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    head :not_found
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  private def topic_params
    params.require_or_empty(:topic).permit(:title, :body)
  end
end
