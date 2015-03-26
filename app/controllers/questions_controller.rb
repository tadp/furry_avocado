class QuestionsController < ApplicationController
  before_action :ensure_current_user

  def create
    @question = current_user.questions.new(question_params)

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
    @question = Question.includes(:upvoters, :downvoters, :tags).find(params[:id])
  end

  def vote
    @question = Question.includes(:votes).find(params[:id])
    @question.votes.find_or_create_by(voter_id: current_user.id, upvoted?: params[:question][:upvoted?])
    redirect_to question_url(@question)
  end

  def create_tags
    @question = Question.includes(:tags).find(params[:id])
    create_or_assign_tags
    redirect_to question_url(@question)
  end

  def destroy_tag_assignment
    @question = Question.includes(:tag_assignments).find(params[:id])
    @tag_assignment = @question.tag_assignments.find_by_tag_id(params[:question][:tag_id])
    @tag_assignment.destroy
    redirect_to question_url(@question)
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def create_or_assign_tags
    tag_names.each do |tag_name|
      tag = Tag.find_by_name(tag_name)

      if tag.nil?
        @question.tags.create(name: tag_name)
      else
        @question.tag_assignments.create(tag_id: tag.id)
      end
    end
  end

  def tag_names
    if params[:question][:tag_names].blank?
      []
    else
      params[:question][:tag_names].split(' ')
    end
  end
end