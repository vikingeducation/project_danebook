class Comment < ApplicationRecord

  validates :body,
            :presence => true

  belongs_to :user
  belongs_to :commentable, polymorphic: true

  def self.send_notification(id, comment_id)
    user = User.find(id)
    comment = Comment.find(comment_id)
    UserMailer.notification(user, comment).deliver
  end
  
end
