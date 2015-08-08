class Comment < ActiveRecord::Base
  validates :body, :user_id, :post_id, presence: true
  validates :body, length: { in: 1.. 140 }

  belongs_to :user
  belongs_to :post

  has_many :likes, :as => :likable


  def likes_by(user)
    likes.where(user_id: user.id)
  end

  def liked_by?(user)
    likes_by(user).any?
  end

  def get_id_of_the_like_by(user)
    liked_by?(user) ? likes_by(user).pluck(:id)[0] : nil
  end
end
