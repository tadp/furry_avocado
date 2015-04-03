# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  commentable_id   :integer          not null
#  commentable_type :string(255)      not null
#  commenter_id     :integer          not null
#  body             :text             not null
#

class Comment < ActiveRecord::Base
  validates :commentable_id, :commentable_type, :commenter_id, :body, presence: true

  belongs_to :commentable, polymorphic: true
  
  belongs_to(
    :commenter,
    class_name: 'User',
    foreign_key: :commenter_id
  )
end
