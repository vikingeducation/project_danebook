class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :commentable, polymorphic: true, touch: true

  has_many :likes, as: :likable
  has_many :user_likes, through: :likes, source: :user

end
