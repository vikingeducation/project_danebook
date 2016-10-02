class Post < ApplicationRecord
  belongs_to :user
  belongs_to :profile

  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates :post_text,
    presence: true
end
