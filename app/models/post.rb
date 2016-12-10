class Post < ApplicationRecord

  belongs_to :user
  has_many :likes
  has_many :likers, through: :likes, source: :user

  validates :content, length: { minimum: 1 }

  def self.reversed
    Post.order(created_at: :desc)
  end

end
