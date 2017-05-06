class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy
  validates :body, presence: true
  validates :user, presence: true
  after_create :queue_notification_email, unless: Proc.new{ self.user_id == self.commentable.user_id }

  include Reusable

  private

  def queue_notification_email
    UserMailer.comment_notification(self).deliver_later
  end




end
