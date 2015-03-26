class Vote < ActiveRecord::Base
  validates :voteable_id, :voteable_type, :voter_id, presence: true
  validates :voteable_id, uniqueness: { scope: [:voteable_type, :voter_id] }
  validates :upvoted?, inclusion: { in: [true, false] }

  belongs_to(
    :voter,
    class_name: 'User',
    foreign_key: :voter_id
  )

  belongs_to :voteable, polymorphic: true
end