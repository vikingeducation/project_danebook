class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  has_many :likes, as: :likable

  validates :body, presence: true, length: { maximum: 5000 }
end
