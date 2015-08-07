class Friending < ActiveRecord::Base

  # ----------------------- Associations --------------------

  # The Initiator side
  belongs_to :friend_initiator, :foreign_key => :friender_id,
                                :class_name => "User"

  # The Recipient side
  belongs_to :friend_recipient, :foreign_key => :friend_id,
                                :class_name => "User"

  # ----------------------- Validations --------------------

  # Make sure we validate the uniqueness of our records
  # to avoid duplicate friendings.  This reflects the 
  # SQL uniqueness constraint we already migrated
  validates :friend_id, :uniqueness => { :scope => :friender_id }

  validates :friender_id, :friend_id,
            :presence => true

  validate :self_friending

  # ----------------------- Methods --------------------

  def self_friending
    errors.add(:friend_id, "can't be friends with yourself!") if friend_id == friender_id
  end

end
