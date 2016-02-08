class Comment < ActiveRecord::Base
  has_many :child_comments, as: :commentable, class_name: "Comment", foreign_key: :commentable_id, dependent: :destroy
  belongs_to :commentable, polymorphic: true
  after_create :send_delayed_notification_email, unless: :commentable_owner
  validates :commentable, presence: true

  include Commentable

  def nested_comments
    Comment.includes(child_comments: [child_comments: [child_comments: [child_comments: [child_comments: :child_comments]]]])
  end

  def commentable_owner
    self.author.id == self.commentable.author.id
  end

  def send_delayed_notification_email
    Comment.delay.send_notification_email(self.commentable.author.id,
                                          self.author.id,
                                          self.commentable.class)
  end

  def self.send_notification_email(to_id, from_id, type)
    user = User.find(to_id)
    from = User.find(from_id)
    UserMailer.comment_notification(user, from, type).deliver
  end

end
