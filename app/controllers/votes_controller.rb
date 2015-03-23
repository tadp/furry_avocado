class VotesController < ApplicationController
  before_action :ensure_current_user

  def create
    @vote = Vote.find_by(vote_params.except(:up?))
    @question = Question.find(vote_params[:question_id])

    if @vote && @vote.up?.to_s != vote_params[:up?]
      @vote.destroy
      alter_vote_rating
    elsif !@vote
      @vote = Vote.new(vote_params)
      @vote.save
      alter_vote_rating
    end

    redirect_to question_url(@question)
  end

  private

  def vote_params
    { voter_id: current_user.id, question_id: params[:question_id], up?: params[:up?] }
  end

  def alter_vote_rating
    if vote_params[:up?] == 'true'
      @question.vote_rating += 1
    else
      @question.vote_rating -= 1
    end

    @question.save
  end
end