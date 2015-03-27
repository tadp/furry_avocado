class TagsController < ApplicationController
  include TagsHelper

  before_action :ensure_current_user

  def create
    if params[:taggable_type] == 'Question'
      create_question_tags
    else
      create_post_tags
    end
  end

  def destroy
    if params[:taggable_type] == 'Question'
      destroy_question_tag
    elsif params[:taggable_type] == 'Post'
      destroy_post_tag
    end
  end

  private

  def create_question_tags
    @question = @taggable = Question.includes(:tags).find(params[:question_id])
    create_or_assign_tags
    redirect_to question_url(@question)
  end

  def create_post_tags

  end

  def destroy_question_tag
    @question = Question.includes(:tags).find(params[:question_id])
    @tag = @question.tags.destroy(params[:id])
    redirect_to question_url(@question)
  end

  def destroy_post_tag

  end

  def tag_params
    params.require(:tag).permit(:tag_names)
  end
end