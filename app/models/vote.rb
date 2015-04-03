# == Schema Information
#
# Table name: votes
#
#  id            :integer          not null, primary key
#  voteable_id   :integer          not null
#  voteable_type :string(255)      not null
#  voter_id      :integer          not null
#  upvoted?      :boolean          not null
#

class Vote < ActiveRecord::Base
  validates :voteable_id, :voteable_type, :voter_id, presence: true
  validates :voteable_id, uniqueness: { scope: [:voteable_type, :voter_id] }
  validates :upvoted, inclusion: { in: [true, false] }

  belongs_to(
    :voter,
    class_name: 'User',
    foreign_key: :voter_id
  )

  belongs_to :voteable, polymorphic: true
end
