class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, as: :likable
  has_many :comments, as: :commentable

  validates :body, presence: true

  def liked_by_user?(user_id)
    self.likes.find_by(user_id: user_id)
  end

end
