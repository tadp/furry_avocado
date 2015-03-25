class Question < ActiveRecord::Base
  validates :title, :body, :author_id, :vote_rating, :view_count, presence: true

  belongs_to(
    :author,
    class_name: 'User',
    foreign_key: :author_id
  )

  has_many :votes, as: :voteable
  has_many :voters, through: :votes, source: :voter

  has_many :tag_assignments, as: :taggable
  has_many :tags, through: :tag_assignments, source: :tag
end