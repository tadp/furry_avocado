class TagAssignment < ActiveRecord::Base
  validates :taggable_id, :tag_id, presence: true
  validates :taggable_id, uniqueness: { scope: [:taggable_type, :tag_id] }

  belongs_to :taggable, polymorphic: true
  belongs_to :tag
end