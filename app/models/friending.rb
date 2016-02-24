class Friending < ActiveRecord::Base

  belongs_to :friend_initiator, foreign_key: :friender_id, class_name: "User", counter_cache: true
  belongs_to :friend_recipient, foreign_key: :friend_id, class_name: "User"
  

  validates :friend_id, uniqueness: {scope: :friender_id}
  validates :friender_id, uniqueness: {scope: :friend_id}



end
