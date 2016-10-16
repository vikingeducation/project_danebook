class Friendship < ApplicationRecord
# The Initiator side
  belongs_to :friend_initiator, :foreign_key => :initiator,
                                :class_name => "User"

  # The Recipient side
  belongs_to :friend_recipient, :foreign_key => :recipient,
                                :class_name => "User"

  # Make sure we validate the uniqueness of our records
  # to avoid duplicate friendings.  This reflects the
  # SQL uniqueness constraint we already migrated
  validates :initiator, :uniqueness => { :scope => :recipient }
end
