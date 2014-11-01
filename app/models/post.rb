class Post < ActiveRecord::Base

  belongs_to :user
  has_many :likes, as: :likable, dependent: :destroy
  has_many :users_who_liked, through: :likes, source: :user

  has_many :comments, as: :commentable
  has_many :users_who_commented, through: :comments, source: :user

  validates_presence_of :body

  def self.newsfeed(user)
    where("user_id IN (?)", user.friends.pluck(:id)).
    order("created_at DESC")
  end
end
