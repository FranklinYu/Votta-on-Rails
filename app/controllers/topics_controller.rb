# frozen_string_literal: true

# @restful_api 1.0
class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :update, :destroy]
  before_action :authenticate, except: [:index, :show]
  before_action :try_authenticate, only: :show

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
    @candidates = @topic.candidates
  end

  # @url /topics
  # @action POST
  #
  # Create a topic to vote for.
  #
  # @required [String] topic[title]
  # @optional [String] topic[body]
  #
  # @response [Topic]
  #
  # @example_request
  #   ```form
  #   topic[title]=Best Restaurant
  #   topic[body]=What's your favorite restaurant?\nDecide it!
  #   ```
  # @example_response
  #   ```json
  #   {
  #     "id": 3,
  #     "title": "Favorite Editor",
  #     "body": "What's your favorite editor? Come to vote!"
  #   }
  #   ```
  def create
    @topic = @current_session.user.topics.create(topic_params)
    if @topic.valid?
      render status: :created
    else
      @error = @topic.errors
      render status: :unprocessable_entity
    end
  end

  # @url /topics/:id
  # @action PATCH
  #
  # Update a topic.
  #
  # @optional [String] topic[title]
  # @optional [String] topic[body]
  #
  # @response [Topic]
  def update
    if @topic.update(topic_params)
      render :show, status: :ok, location: @topic
    else
      render json: @topic.errors, status: :unprocessable_entity
    end
  end

  # @url /topics/:id
  # @action DELETE
  #
  # Delete a topic.
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
