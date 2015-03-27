class ResponsesController < ApplicationController
  before_action :ensure_current_user

  def create
    @question = Question.find(params[:question_id])
    @response = @question.responses.create(response_params)
    redirect_to question_url(@question)
  end

  def destroy 
    @question = Question.find(params[:question_id])
    @response = @question.responses.find(params[:id])
    @response.destroy
    redirect_to question_url(@question)
  end

  private

  def response_params
    params.require(:response).permit(:body).merge(author_id: current_user.id)
  end
end