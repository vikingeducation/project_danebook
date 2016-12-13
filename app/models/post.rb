class Post < ApplicationRecord
  belongs_to :user
  validates :body, presence: true, length: { maximum: 255 }
  has_many :likes, :as => :likeable
  has_many :comments, :as => :commentable

end
