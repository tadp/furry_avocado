class VotesController < ApplicationController
  before_action :ensure_current_user

  def create
    @vote = Vote.new(vote_params)
    @vote.save
    redirect_to question_url(@vote.voteable)
  end

  private

  def vote_params
    {
      voter_id: current_user.id,
      voteable_id: params[:id],
      voteable_type: params[:voteable_type],
      upvoted?: params[:upvoted?]
    }
  end
end