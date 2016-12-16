class Notice < ApplicationRecord
  belongs_to :user

  def self.destroy_for_user(user)
    FriendRequest.
    where(user_id: user.id).destroy_all
  end
end
