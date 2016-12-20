class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  has_many :likes, as: :likable

  validates :body, length: { maximum: 10000 }
end
