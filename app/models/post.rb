class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, as: :likeable,  dependent: :destroy
  has_many :likers, through: :likes, source: :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :comment_likes, through: :comments, source: :likes
  validates :body, presence: true

  include Reusable
end
