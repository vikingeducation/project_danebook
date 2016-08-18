class Friending < ApplicationRecord

  belongs_to :friend_initiator, :foreign_key => :friender_id, :class_name => "User"
  belongs_to :friend_recipient, :foreign_key => :friended_id, :class_name => "User"

  validates :friended_id, :uniqueness => { :scope => :friender_id }
end
