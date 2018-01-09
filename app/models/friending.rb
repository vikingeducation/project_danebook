class Friending < ApplicationRecord

  # The Initiator side
  belongs_to :friend_initiator, :foreign_key => :initiator_id,
                                :class_name => "User"

  # The Recipient side
  belongs_to :friend_recipient, :foreign_key => :recipient_id,
                                :class_name => "User"

  validates :recipient_id, :uniqueness => { :scope => :initiator_id }
end
