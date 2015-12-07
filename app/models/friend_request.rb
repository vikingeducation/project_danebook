class FriendRequest < ActiveRecord::Base
  include Dateable
  include Friendable

  after_update :create_friendship_if_approved

  after_create :queue_notification_email

  def accept
    update(:approved => true)
  end

  def queue_notification_email
    FriendRequest.delay.send_notification_email(id)
  end

  def self.send_notification_email(id)
    friend_request = FriendRequest.find(id)
    NotificationMailer.friend_request(friend_request).deliver!
  end


  private
  def create_friendship_if_approved
    if approved?
      transaction do
        Friendship.create!(
          :initiator_id => initiator.id,
          :approver_id => approver.id
        )
        destroy!
      end
    end
  end
end
