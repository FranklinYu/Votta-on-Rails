# frozen_string_literal: true

class CandidatesController < ApplicationController
  before_action :set_candidate, except: [:index, :create]
  before_action :authenticate, except: [:index, :show]

  # GET /candidates
  # GET /candidates.json
  def index
    @candidates = Candidate.all
  end

  # GET /candidates/1
  # GET /candidates/1.json
  def show
  end

  # POST /candidates
  # POST /candidates.json
  def create
    @candidate = Candidate.new(candidate_params)

    if @candidate.save
      render :show, status: :created, location: @candidate
    else
      render json: @candidate.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /candidates/1
  # PATCH/PUT /candidates/1.json
  def update
    if @candidate.update(candidate_params)
      render :show, status: :ok, location: @candidate
    else
      render json: @candidate.errors, status: :unprocessable_entity
    end
  end

  # DELETE /candidates/1
  # DELETE /candidates/1.json
  def destroy
    @candidate.destroy
  end

  def vote_up
    vote = @candidate.votes.create(user: @current_session.user)
    @errors = vote.errors unless @candidate.valid?
    if @candidate.valid?
      render status: :created
    else
      @errors = vote.errors
      render status: :unprocessable_entity
    end
  end

  def cancel_up_vote
    vote = Vote.find_by_user_id_and_candidate_id(@current_session.user.id, @candidate.id)
    if vote.nil?
      render status: :not_found
    else
      vote.destroy
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_candidate
      @candidate = Candidate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def candidate_params
      params.require_or_empty(:candidate).permit(:body)
        .merge(user_id: @current_session.user.id, topic_id: params['topic_id'] || @candidate.topic_id)
    end
end
