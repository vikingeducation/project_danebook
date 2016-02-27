class Comment < ActiveRecord::Base

  # ----------------------- Associations --------------------

  belongs_to :commentable, :polymorphic => true

  include Commentable

  include Likeable

  belongs_to :author, foreign_key: "author_id",
                      class_name: "User"

  # ----------------------- Validations --------------------

  validates :author_id, :body, :commentable,
            presence: true

  # ----------------------- Callbacks --------------------

  after_create :notify_user

  # ----------------------- Methods --------------------

  def notify_user
    Comment.delay.send_email_notification(self.id)
  end

  def self.send_email_notification(id)
    comment = Comment.find(id)
    CommentMailer.notify(comment).deliver
  end

end
