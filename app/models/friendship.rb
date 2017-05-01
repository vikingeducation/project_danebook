class Friendship < ApplicationRecord
  belongs_to :friend_initiator, class_name: 'User', foreign_key: :friender_id
  belongs_to :friend_recipient, class_name: 'User', foreign_key: :friendee_id
  after_update :reciprocate_friendship, if: :friendship_accepted?, on: [:update]
  after_destroy :reciprocate_breakup, :update_user_friendships_count
  after_create :update_user_friendships_count
  validates_uniqueness_of :friend_initiator, scope: :friend_recipient

  validate :no_friending_of_self
  validates :rejected, inclusion: { in: [nil, true, false]}

  def no_friending_of_self
    if self.friender_id == self.friendee_id
      errors.add(:friender_id, "Can't friend self")
    end
  end


  def update_user_friendships_count
    # we use this instead of the built-in rails counter_cache because we don't want to count friendships where rejected is true
    friender = self.friend_initiator
    friender.friendships_count = Friendship.where('rejected IS ? AND friender_id = ?', false, friender.id).count
    friender.save
  end

  private

  def friendship_accepted?
    self.persisted? && self.rejected == false
  end

  def reciprocate_breakup
    f = Friendship.find_by(friender_id: self.friendee_id, friendee_id: self.friender_id)
    if f.present?
      f.destroy
    end
  end

  def reciprocate_friendship
    unless self.rejected
      f = Friendship.new(friender_id: self.friendee_id, friendee_id: self.friender_id, rejected: false)
      f.save
    end
  end


end
