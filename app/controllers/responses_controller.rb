class ResponsesController < ApplicationController
  before_action :ensure_current_user

  def create
    @question = Question.includes(:author, :responses).find(params[:question_id])

    unless @question.author == current_user
      @response = @question.responses.create(response_params)
    end
    
    redirect_to question_url(@question)
  end

  def destroy 
    @question = Question.includes(:responses).find(params[:question_id])
    @response = @question.responses.find(params[:id])

    if @response.author == current_user
      @response.destroy
    end

    redirect_to question_url(@question)
  end

  def create_vote
    @question = Question.includes(:responses).find(params[:question_id])
    @response = @question.responses.find(params[:id])

    unless @response.author == current_user
      @response.votes.find_or_create_by(vote_params)
    end

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