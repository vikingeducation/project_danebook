class Comment < ActiveRecord::Base
  include Dateable

  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  has_many :likes, :as => :likeable, :dependent => :destroy

  validates :body,
            :presence => true

  validates :user,
            :presence => true

  validate :presence_of_commentable

  after_create :queue_notification_email

  def queue_notification_email
    Comment.delay.send_notification_email(id)
  end

  def self.send_notification_email(id)
    comment = Comment.find(id)
    NotificationMailer.comment(comment).deliver!
  end

  private
  def presence_of_commentable
    unless commentable_id.present? && commentable_type.present?
      errors.add(:base, 'You cannot comment on that!')
    end
  end
end
