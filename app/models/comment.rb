class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :commenter, class_name: "User", foreign_key: :commenter_id

  has_many :comments, as: :commentable
end
