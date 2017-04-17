class Friendship < ApplicationRecord
  belongs_to :friend_initiator, class_name: 'User', foreign_key: :friender_id, counter_cache: :friendships_count
  belongs_to :friend_recipient, class_name: 'User', foreign_key: :friendee_id
  validates_uniqueness_of :friend_initiator, scope: :friend_recipient
  validate :no_friending_of_self

  def no_friending_of_self
    if self.friender_id == self.friendee_id
      errors.add(:friender_id, "Can't friend self")
    end
  end


end
