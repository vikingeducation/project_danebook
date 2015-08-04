class Post < ActiveRecord::Base
  has_many :comments, as: :commentable
  has_many :likes, as: :likable
  belongs_to :author, class_name: "User", foreign_key: :user_id

  def has_likes?
    self.likes.count > 0
  end

  def posted_on
    "Posted on " + self.created_at.strftime("%A %m/%d/%Y")
  end
end
