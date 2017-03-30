class Post < ApplicationRecord

  belongs_to :user
  has_many :likes, as: :likable, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  has_many :comments, as: :commentable
  has_many :commenters, through: :comments, source: :user

  validates_presence_of :body, :user
  validates :body, length: { maximum: 500 }

end
