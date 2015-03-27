class VotesController < ApplicationController
  before_action :ensure_current_user

  def create
    if params[:voteable_type] == 'Question'
      create_question_vote
    else
      create_response_vote
    end
  end

  def create_question_vote
    @question = Question.includes(:votes).find(params[:question_id])
    @question.votes.create(vote_params)
    redirect_to question_url(@question)
  end

  def create_response_vote
    @response = Response.includes(:votes).find(params[:response_id])
    @response.votes.create(vote_params)
    redirect_to question_url(params[:question_id])
  end

  private

  def vote_params
    params.require(:vote).permit(:upvoted?).merge(voter_id: current_user.id)
  end
end