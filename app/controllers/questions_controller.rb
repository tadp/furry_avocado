class QuestionsController < ApplicationController
  before_action :ensure_current_user

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.new(question_params)
    @question.vote_rating = 0

    if @question.save
      redirect_to question_url(@question)
    else
      render :new
    end
  end

  def show
    @question = Question.find(params[:id])
  end

  private

  def ensure_current_user
    unless signed_in?
      redirect_to new_session_url
    end
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end