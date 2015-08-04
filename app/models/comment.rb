class Comment < ActiveRecord::Base
  has_many :child_comments, as: :commentable, class_name: "Comment", foreign_key: :commentable_id
  belongs_to :commentable, polymorphic: true
  belongs_to :author, class_name: "User", foreign_key: :user_id

  def nested_comments
    Comment.includes(child_comments: [child_comments: [child_comments: [child_comments: [child_comments: :child_comments]]]])
  end

end
