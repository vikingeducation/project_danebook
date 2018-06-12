class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :post
  has_many :likes, as: :likable
  has_many :user_likes, through: :likes, source: :user

end
