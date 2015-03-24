class QuestionsController < ApplicationController
  before_action :ensure_current_user

  def new
    @question = Question.new
    # 5.times { @question.tags.new }
  end

  def create
    @question = current_user.questions.new(
      question_params.merge({
        vote_rating: 0,
        view_count: 0
      })
    )

    if @question.save
      redirect_to question_url(@question)
    else
      render :new
    end
  end

  def show
    @question = Question.find(params[:id])
    @question.view_count += 1
    @question.save
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end
end