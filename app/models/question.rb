class Question < ActiveRecord::Base
  validates :title, :body, :author_id, :vote_rating, :view_count, presence: true

  belongs_to(
    :author,
    class_name: 'User',
    foreign_key: :author_id
  )

  has_many :votes, as: :voteable

  has_many :upvoters, -> { where votes: { upvoted?: true } }, through: :votes, source: :voter
  has_many :downvoters, -> { where votes: { upvoted?: false } }, through: :votes, source: :voter

  has_many :tag_assignments, as: :taggable
  has_many :tags, through: :tag_assignments, source: :tag

  def upvotes
    votes.where(upvoted?: true)
  end

  def downvotes
    votes.where(upvoted?: false)
  end
end