class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :commentable, polymorphic: true, touch: true

  validates :user, :commentable, presence: true
  
  has_many :likes, as: :likable
  has_many :user_likes, through: :likes, source: :user


  private

  def self.send_comment_notification(id)
    comment = Comment.find(id)
    UserMailer.comment_notification(comment).deliver!
  end

end
