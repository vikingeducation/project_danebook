class Post < ApplicationRecord
  belongs_to :user, foreign_key: :user_id, optional: true

  has_many :likes, as: :likeable
  validates :body, length: { minimum: 1 }
end
