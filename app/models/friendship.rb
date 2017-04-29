class Friendship < ApplicationRecord
  belongs_to :friend_initiator, class_name: 'User', foreign_key: :friender_id, counter_cache: :friendships_count
  belongs_to :friend_recipient, class_name: 'User', foreign_key: :friendee_id
  after_update :reciprocate_friendship, on: [:accept]
  after_destroy :reciprocate_breakup
  validates_uniqueness_of :friend_initiator, scope: :friend_recipient

  validate :no_friending_of_self
  validate :no_friending_if_previously_rejected
  validates :status, inclusion: { in: [nil, 'sent', 'rejected', 'accepted']}

  def no_friending_of_self
    if self.friender_id == self.friendee_id
      errors.add(:friender_id, "Can't friend self")
    end
  end

  def no_friending_if_previously_rejected
    if self.status == 'rejected'
      errors.add(:status, "Can't add that person")
    end
  end

  private

  def reciprocate_breakup
    f = Friendship.find_by(friender_id: self.friendee_id, friendee_id: self.friender_id)
    if f.present?
      f.destroy
    end
  end


  def send_invite_if_not_previously_rejected
    self.status = 'sent' unless self.status == 'rejected'
  end

  def reciprocate_friendship
    f = Friendship.new(friender_id: self.friendee_id, friendee_id: self.friender_id, status: 'accepted')
    f.save
  end


end
