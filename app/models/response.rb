class Response < ActiveRecord::Base
  validates :body, :author_id, :question_id, presence: true

  belongs_to(
    :author,
    class_name: 'User',
    foreign_key: :author_id
  )
  
  belongs_to :question
  has_many :votes, as: :voteable
  has_many :upvoters, -> { where votes: { upvoted?: true } }, through: :votes, source: :voter
  has_many :downvoters, -> { where votes: { upvoted?: false } }, through: :votes, source: :voter  
end 