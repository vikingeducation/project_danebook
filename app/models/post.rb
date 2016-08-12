class Post < ActiveRecord::Base

  belongs_to :author, class_name: "User", foreign_key: "user_id"
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  validates :body, length: { minimum: 1 }

  def recent_likes
    likes.order('created_at DESC').limit(3).map {|like| like.user.to_s}.join(", ")
  end


end
