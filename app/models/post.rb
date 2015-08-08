class Post < ActiveRecord::Base
  validates :body, :user_id, presence: true
  validates :body, length: { in: 1..400 }

  belongs_to :user
  has_one :profile, through: :user

  has_many :comments, 
           :dependent => :destroy
  has_many :likes, 
           :as => :likable, 
           :dependent => :destroy

  def likes_by(user)
    likes.where(user_id: user.id).includes(:user)
  end

  def liked_by?(user)
    likes_by(user).any?
  end

  def get_id_of_the_like_by(user)
    liked_by?(user) ? likes_by(user).pluck(:id)[0] : nil
  end
end
