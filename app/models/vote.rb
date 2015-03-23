class Vote < ActiveRecord::Base
  validates :question_id, :voter_id, presence: true
  validates_uniqueness_of :question_id, scope: :voter_id
  validates :up?, inclusion: { in: [true, false] }

  belongs_to(
    :voter,
    class_name: 'User',
    foreign_key: :voter_id
  )

  belongs_to :question
end