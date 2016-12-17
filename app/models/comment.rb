class Comment < ApplicationRecord

  belongs_to :author, class_name: 'User', foreign_key: :author_id
  belongs_to :commentable, polymorphic: true

  has_many :likes, as: :likeable, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  validates :body, length: { in: 1..1000 }

  def total_likes
    likes.count
  end

  def random_liker
    likers.sample.full_name
  end

end
