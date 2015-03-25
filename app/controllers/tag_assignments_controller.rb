class TagAssignmentsController < ApplicationController
  before_action :ensure_current_user

  def create
    tag_names = params[:question][:tag_names].split(' ')
    question = Question.includes(:tags).find(params[:tag_assignment][:taggable_id])

    (5 - question.tags.length).times do |num|
      break if num == tag_names.length
      tag = Tag.find_or_create_by(name: tag_names[num])
      TagAssignment.create(tag_assignment_params.merge({ tag_id: tag.id }))
    end

    redirect_to question_url(params[:tag_assignment][:taggable_id])
  end

  def destroy
    @tag_assignment = TagAssignment.includes(:taggable).find(params[:id])
    @tag_assignment.destroy
    redirect_to question_url(@tag_assignment.taggable)
  end

  private

  def tag_assignment_params
    params.require(:tag_assignment).permit(:taggable_id, :taggable_type)
  end
end