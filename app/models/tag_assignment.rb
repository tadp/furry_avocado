# == Schema Information
#
# Table name: tag_assignments
#
#  id            :integer          not null, primary key
#  taggable_id   :integer          not null
#  taggable_type :string(255)      not null
#  tag_id        :integer          not null
#

class TagAssignment < ActiveRecord::Base
  validates :taggable_id, :taggable_type, :tag_id, presence: true
  validates :taggable_id, uniqueness: { scope: [:taggable_type, :tag_id] }
  validates :taggable_type, inclusion: { in: %w(Question Response), message: "%{value} is not a valid type" }

  belongs_to :tag
  belongs_to :taggable, polymorphic: true
end
