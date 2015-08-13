class Friending < ActiveRecord::Base

  #=================== associations =========================

  #person clicking friend button
  belongs_to :friend_initiator, :foreign_key => :friender_id,
                                :class_name => "User"

  # person being friended
  belongs_to :friend_recipient, :foreign_key => :friend_id,
                                :class_name => "User"

  #=================== validations =========================

  validates :friend_id, :uniqueness => { :scope => :friender_id }

end
