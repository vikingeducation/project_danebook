class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :likes, as: :likable

  def liked_by_user?(user_id)
    self.likes.find_by(user_id: user_id)
  end
  
end
