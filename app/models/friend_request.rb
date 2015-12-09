class FriendRequest < ActiveRecord::Base
  include Dateable
  include Friendable
  include Notifiable

  after_update :create_friendship_if_approved

  def accept
    update(:approved => true)
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
