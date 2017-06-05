class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy
  has_one :activity, as: :activable, dependent: :destroy
  validates :body, presence: true
  validates :user, presence: true
  after_create :create_activity_feed_record

  after_create :send_notification_email, unless: Proc.new{ self.user_id == self.commentable.user_id }

  include Reusable

  private

  def send_notification_email
    # if we set ENV['USE_DELAYED_EMAILS'] to 'true', it will use delayed emails
    if Rails.application.secrets.use_delayed_emails == 'true'
      UserMailer.comment_notification(self).deliver_later
    else
      UserMailer.comment_notification(self).deliver!
    end
  end


end
