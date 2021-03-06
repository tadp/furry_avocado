# == Schema Information
#
# Table name: questions
#
#  id        :integer          not null, primary key
#  author_id :integer          not null
#  title     :string(255)      not null
#  body      :text
#

class Question < ActiveRecord::Base
  validates :title, :body, :author_id, presence: true

  belongs_to(
    :author,
    class_name: 'User',
    foreign_key: :author_id
  )

  has_many :votes, as: :voteable
  has_many :upvoters, -> { where votes: { upvoted: true } }, through: :votes, source: :voter
  has_many :downvoters, -> { where votes: { upvoted: false } }, through: :votes, source: :voter

  has_many :tag_assignments, as: :taggable
  has_many :tags, through: :tag_assignments, source: :tag

  has_many :responses
  has_one :accepted_response, -> { where responses: { accepted: true } }, class_name: 'Response', foreign_key: :question_id

  has_many :comments, as: :commentable
  has_many :commenters, through: :comments, source: :commenter

  # validates_associated :tag_assignments, :length => { :maximum => 5}

  # def limit_tags
  #   errors.add(:tags, 'The question already contains 5 tags') if tags.length == 5
  # end

  # def upvotes
  #   votes.where(upvoted?: true)
  # end

  # def downvotes
  #   votes.where(upvoted?: false)
  # end
end
