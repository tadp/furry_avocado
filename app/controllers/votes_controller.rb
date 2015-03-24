class VotesController < ApplicationController
  before_action :ensure_current_user

  def create
    @vote = Vote.includes(:voteable).find_by(vote_params.except(:up?))

    if @vote && @vote.up?.to_s != vote_params[:up?]
      @vote.destroy
      alter_vote_rating
    elsif !@vote
      @vote = Vote.new(vote_params)
      @vote.save
      alter_vote_rating
    end

    redirect_to question_url(@vote.voteable)
  end

  private

  def vote_params
    { voter_id: current_user.id, voteable_id: params[:voteable_id], voteable_type: params[:voteable_type], up?: params[:up?] }
  end

  def alter_vote_rating
    if vote_params[:up?] == 'true'
      @vote.voteable.vote_rating += 1
    else
      @vote.voteable.vote_rating -= 1
    end

    @vote.voteable.save
  end
end