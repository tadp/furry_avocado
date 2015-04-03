# == Schema Information
#
# Table name: posts
#
#  id    :integer          not null, primary key
#  title :string(255)      not null
#  body  :text             not null
#

class Post < ActiveRecord::Base
  validates :title, :body, presence: true

  has_many :tag_assignments, as: :taggable
  has_many :tags, through: :tag_assignments, source: :tag

  has_many :comments, as: :commentable
  has_many :commenters, through: :comments, source: :commenter
end

