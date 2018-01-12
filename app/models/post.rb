class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, as: :likeable
  has_many :comments, as: :commentable

  validates :user_id, :user, :body, presence: true

  def has_likes?
    likes.count > 0
  end

  def has_comments?
    comments.count > 0
  end

end
