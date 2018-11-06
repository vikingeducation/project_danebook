class Post < ApplicationRecord

  belongs_to :user, inverse_of: :posts

  validates :user, presence: true 

  has_many :likes, as: :likable
  has_many :user_likes, through: :likes, source: :user

  has_many :comments, as: :commentable
  has_many :user_comments, through: :comments, source: :user

end
