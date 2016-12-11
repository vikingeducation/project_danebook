class FriendRequest < ApplicationRecord
  belongs_to :user
  belongs_to :request, class_name: "User"

  validates_uniqueness_of :request_id, scope: [:user_id]
end
