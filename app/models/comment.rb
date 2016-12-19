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

  def self.comment_email(id, other_user)
    user = User.find(id)
    other_user = User.find(other_user)
    CommentMailer.comment(user, other_user).deliver
  end

end
