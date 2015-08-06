class Friending < ActiveRecord::Base

  belongs_to :friend_initiator, :foreign_key => :friender_id, 
                                :class_name => "User"

  belongs_to :friend_recipient, :foreign_key => :friender_id,
                                :class_name => "User"
end
