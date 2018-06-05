class Post < ApplicationRecord

  belongs_to :user, inverse_of: :posts
  has_many :likes
  has_many :user_likes, through: :likes, source: :user
  has_many :comments

end
