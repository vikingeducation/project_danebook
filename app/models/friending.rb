class Friending < ActiveRecord::Base

  belongs_to :friend_initiator, class_name: "User", foreign_key: :friender_id
  belongs_to :friend_recipient, class_name: "User", foreign_key: :friend_id

  validates :friend_id, uniqueness: { scope: :friender_id }

end
