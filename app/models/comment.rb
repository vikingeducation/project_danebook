class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :likes, as: :likable, dependent: :destroy
  validates_presence_of :user, :commentable, :content
  validates :content, length: { :in => 1..300 }


  def self.send_new_comment_notification(comment)
    user = comment.commentable.user
    UserMailer.new_comment(user).deliver!
  end


end
