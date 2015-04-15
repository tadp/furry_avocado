class QuestionsController < ApplicationController
  include TagsHelper

  before_action :ensure_current_user, except: [:index, :show]

  def create
    @question = @taggable = current_user.questions.new(question_params)

    if @question.save
      create_or_assign_tags
      redirect_to question_url(@question)
    else
      render :new
    end
  end

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def show
    @question = Question.includes(:author, :upvoters, :downvoters, :tags, :responses, :comments).find(params[:id])
    @author_is_current_user = @question.author == current_user
  end

  def create_vote
    @question = Question.includes(:author, :votes).find(params[:id])

    unless @question.author == current_user
      @question.votes.find_or_create_by(vote_params)
    end

    redirect_to question_url(@question)
  end

  def create_tags
    @question = @taggable = Question.includes(:author, :tags).find(params[:id])

    if @question.author == current_user
      create_or_assign_tags
    end

    redirect_to question_url(@question)
  end

  def destroy_tag
    @question = Question.includes(:author, :tags).find(params[:id])

    if @question.author == current_user
      @tag = @question.tags.destroy(params[:tag_id])
    end

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