class Friending < ActiveRecord::Base
  validates :friend_id, :uniqueness => { :scope => :friender_id }

  validate :user_cannot_friend_himself

  # The Initiator side
  belongs_to :friend_initiator, :foreign_key => :friender_id,
                                :class_name => "User"

  # The Recipient side
  belongs_to :friend_recipient, :foreign_key => :friend_id,
                                :class_name => "User" 


  def user_cannot_friend_himself
    errors.add(:friend_id, "Cannot friend youself") if friend_id == friender_id
  end
  
end
