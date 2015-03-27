class QuestionsController < ApplicationController
  include TagsHelper

  before_action :ensure_current_user

  def create
    @question = @taggable = current_user.questions.new(question_params)

    if @question.save
      create_or_assign_tags
      redirect_to question_url(@question)
    else
      render :new
    end
  end

  def new
    @question = Question.new
  end

  def show
    @question = Question.includes(:upvoters, :downvoters, :tags, :responses).find(params[:id])
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def tag_params
    params.require(:question).permit(:tag_names)
  end
end