class Friendship < ActiveRecord::Base
  include Dateable
  include Friendable
  include Feedable
  include Notifiable

  feedable_user_methods :initiator, :approver
  feedable_actions :create

  before_create :create_friendship_if_request_exists


  private
  def create_friendship_if_request_exists
    friend_request = FriendRequest.find_by_user_ids(initiator_id, approver_id)
    unless friend_request.present? && friend_request.first.approved?
      raise ActiveRecord::RecordNotFound, 'Cannot create friendship without an approved friend request'
    end
  end
end
