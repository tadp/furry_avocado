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

  def create_vote
    @question = Question.includes(:votes).find(params[:id])
    @question.votes.find_or_create_by(vote_params)
    redirect_to question_url(@question)
  end

  def create_tags
    @question = @taggable = Question.includes(:tags).find(params[:id])
    create_or_assign_tags
    redirect_to question_url(@question)
  end

  def destroy_tag
    @question = Question.includes(:tags).find(params[:id])
    @tag = @question.tags.destroy(params[:tag_id])
    redirect_to question_url(@question)
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def vote_params
    params.require(:vote).permit(:upvoted).merge(voter_id: current_user.id)
  end

  def tag_params
    params.require(:tag).permit(:tag_names)
  end
end