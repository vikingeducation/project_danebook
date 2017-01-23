class Friending < ApplicationRecord

  # initiator side
  belongs_to :friend_initiator, foreign_key: :friender_id, class_name: "User"

  # recipient side
  belongs_to :friend_recipient, foreign_key: :friend_id, class_name: "User"

  # validate uniqueness to avoid duplicate friends
  validates :friend_id, uniqueness: { scope: :friender_id }
end
