class Comment < ActiveRecord::Base

  belongs_to :user

  belongs_to :commentable, polymorphic: :true

  has_many :likes, as: :likable, dependent: :destroy
  has_many :users_who_liked, through: :likes, source: :user

  validates_presence_of :body, :user_id
  validates :body, length: { maximum: 500 }





  def self.send_notification_email(comment_id)
    ENV["DELAY_EMAILS"] == "true" ? delay.notify(comment_id) : notify(comment_id)
  end



  # actual notification method
  def self.notify(comment_id)
    comment = Comment.find(comment_id)

    # parse the polymorphic commentable
    klass = comment.commentable_type.constantize
    commentable = klass.find(comment.commentable_id)
    user = commentable.user

    # don't email if you're commenting on yourself
    unless comment.user == commentable.user
      UserMailer.notify_comment(user, commentable).deliver
    end
  end


end
