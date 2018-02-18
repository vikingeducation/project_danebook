class Friending < ApplicationRecord

  belongs_to :friend_initiator, :class_name => 'User',
                                :foreign_key => :friender_id

  belongs_to :friend_recipent,  :class_name => 'User',
                                :foreign_key => :friend_id

  validates :friend_id, :uniqueness => {:scope => :friender_id}
  validates :friend_id, :friender_id, :presence => true

  validate :cannot_friend_self

  def cannot_friend_self
    errors.add(:friend_id, "cannot friend self") unless friender_id != friend_id
  end
end
