class Comment < ActiveRecord::Base
  has_many :child_comments, as: :commenting, class_name: "Comment", foreign_key: :commenting_id, dependent: :destroy
  #has_many :likes, as: :likable, dependent: :destroy
  belongs_to :commenting, polymorphic: true
  belongs_to :author, class_name: "User", foreign_key: :user_id

  # def nested_comments
  #   Comment.includes(child_comments: [child_comments: [child_comments: [child_comments: [child_comments: :child_comments]]]])
  # end

  def posted_on
    "Posted on " + self.created_at.strftime("%A %m/%d/%Y")
  end
end
