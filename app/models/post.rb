class Post < ApplicationRecord
  belongs_to :user, foreign_key: :user_id, optional: true

  has_many :likes, as: :likeable
  has_many :comments, as: :commentable
  validates :body, length: { minimum: 1 }
end
