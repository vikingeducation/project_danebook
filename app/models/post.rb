class Post < ActiveRecord::Base
  has_many :comments, -> { order('created_at ASC') }, as: :commentable, dependent: :destroy
  has_many :likes, as: :likable, dependent: :destroy
  has_many :people_who_like, through: :likes, source: :user
  belongs_to :author, class_name: "User", foreign_key: :user_id

  def has_likes?
    self.likes.count > 0
  end

  def posted_on
    "Posted on " + self.created_at.strftime("%A %m/%d/%Y")
  end
end
