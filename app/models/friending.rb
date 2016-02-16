class Friending < ActiveRecord::Base
  belongs_to :friend_initiator, class_name: "User", foreign_key: :friender_id
  belongs_to :friend_receiver, class_name: "User", foreign_key: :friend_id
end
