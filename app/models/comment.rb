class Comment < ActiveRecord::Base
  has_many :child_comments, as: :commentable, class_name: "Comment", foreign_key: :commentable_id, dependent: :destroy
  has_many :likes, as: :likable, dependent: :destroy
  has_many :people_who_like, through: :likes, source: :user
  belongs_to :commentable, polymorphic: true
  belongs_to :author, class_name: "User", foreign_key: :user_id

  def nested_comments
    Comment.includes(child_comments: [child_comments: [child_comments: [child_comments: [child_comments: :child_comments]]]])
  end

  def posted_on
    "Posted on " + self.created_at.strftime("%A %m/%d/%Y")
  end
end
