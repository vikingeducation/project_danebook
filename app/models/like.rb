class Like < ActiveRecord::Base
  include Dateable
  include Feedable

  feedable_user_method :user
  feedable_actions :create
  
  belongs_to :user
  belongs_to :likeable, :polymorphic => true

  validates :user,
            :presence => true

  validate :presence_of_likeable

  after_create :queue_notification_email

  def queue_notification_email
    Like.delay.send_notification_email(id)
  end

  def self.send_notification_email(id)
    like = Like.find(id)
    NotificationMailer.like(like).deliver!
  end


  private
  def presence_of_likeable
    unless likeable_type.present? && likeable_id.present?
      errors.add(:base, 'You cannot like that!')
    end
  end
end
