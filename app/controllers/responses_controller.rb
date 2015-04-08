class ResponsesController < ApplicationController
  before_action :ensure_current_user

  def create
    @question = Question.includes(:responses).find(params[:question_id])
    @response = @question.responses.create(response_params)
    redirect_to question_url(@question)
  end

  def destroy 
    @question = Question.includes(:responses).find(params[:question_id])
    @response = @question.responses.find(params[:id])
    @response.destroy
    redirect_to question_url(@question)
  end

  def create_vote
    @question = Question.includes(:responses).find(params[:question_id])
    @response = @question.responses.find(params[:id])
    @response.votes.find_or_create_by(vote_params)
    redirect_to question_url(@question)
  end

  private

  def response_params
    params.require(:response).permit(:body).merge(author_id: current_user.id)
  end

  def vote_params
    params.require(:vote).permit(:upvoted).merge(voter_id: current_user.id)
  end
end