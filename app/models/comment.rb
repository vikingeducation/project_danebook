class Comment < ActiveRecord::Base
  has_many :child_comments, as: :commentable, class_name: "Comment", foreign_key: :commentable_id, dependent: :destroy
  belongs_to :commentable, polymorphic: true
  after_create :send_delayed_notification_email

  include Commentable

  def nested_comments
    Comment.includes(child_comments: [child_comments: [child_comments: [child_comments: [child_comments: :child_comments]]]])
  end

  def send_delayed_notification_email
    unless self.commentable && self.author.id == self.commentable.author.id
      Comment.delay.send_notification_email(self.author.id)
    end
  end

  def self.send_notification_email(id)
    user = User.find(id)
    UserMailer.welcome(user).deliver
  end

end
