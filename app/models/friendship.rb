class Friendship < ActiveRecord::Base
  include Dateable
  include Friendable

  before_create :create_friendship_if_request_exists

  after_create :queue_notification_email

  def queue_notification_email
    Friendship.delay.send_notification_email(id)
  end

  def self.send_notification_email(id)
    friendship = Friendship.find(id)
    NotificationMailer.friendship(friendship).deliver!
  end


  private
  def create_friendship_if_request_exists
    friend_request = FriendRequest.find_by_user_ids(initiator_id, approver_id)
    unless friend_request.present? && friend_request.first.approved?
      raise ActiveRecord::RecordNotFound, 'Cannot create friendship without an approved friend request'
    end
  end
end
