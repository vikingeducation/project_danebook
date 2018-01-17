class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :likes, as: :likeable

  validates :body, presence: true

  def has_likes?
    likes.count > 0
  end
end
