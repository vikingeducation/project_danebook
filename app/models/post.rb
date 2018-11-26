class Post < ApplicationRecord

  belongs_to :user, inverse_of: :posts

  validates :user, :body, presence: true
  validates :body, length: { minimum: 2 }

  has_many :likes, as: :likable, dependent: :destroy
  has_many :user_likes, through: :likes, source: :user, dependent: :destroy 

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :user_comments, through: :comments, source: :user, dependent: :destroy

end
