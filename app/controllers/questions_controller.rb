class QuestionsController < ApplicationController
  before_action :ensure_current_user

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.new(
      question_params.merge({
        vote_rating: 0,
        view_count: 0
      })
    )

    if @question.save
      find_or_create_tags_and_tag_assignments
      redirect_to question_url(@question)
    else
      render :new
    end
  end

  def show
    @question = Question.includes(:tags, :tag_assignments).find(params[:id])
    @question.view_count += 1
    @question.save
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def find_or_create_tags_and_tag_assignments
    tag_names = params[:question][:tag_names].split(' ')

    5.times do |num|
      break if num == tag_names.length
      tag = Tag.find_or_create_by(name: tag_names[num])
      TagAssignment.create(tag_id: tag.id, taggable_id: @question.id, taggable_type: "Question")
    end
  end
end