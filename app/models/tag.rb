# == Schema Information
#
# Table name: tags
#
#  id   :integer          not null, primary key
#  name :string(255)      not null
#

class Tag < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :tag_assignments
  has_many :questions, through: :tag_assignments, source: :taggable, source_type: "Question"
end
