class Comment < ApplicationRecord
  has_many :likes, :as => :likeable
  validates :body, presence: true
  belongs_to :post
  has_many :comments, :as => :commentable
end
