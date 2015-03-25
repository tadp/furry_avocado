class Tag < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :tag_assignments
  has_many :questions, through: :tag_assignments, source: :taggable, source_type: "Question"
end