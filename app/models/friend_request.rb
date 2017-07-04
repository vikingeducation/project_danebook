class FriendRequest < ApplicationRecord

  belongs_to :initiator,
             :foreign_key => :user_one_id,
             :class_name => "User"

  belongs_to :recipient,
             :foreign_key => :user_two_id,
             :class_name => "User"

  belongs_to :status

  validates :user_one_id, uniqueness: {scope: :user_two_id}

  private

  def self.relationship_between(user1_id, user2_id)
    where(
      "(user_one_id = :user1 AND user_two_id = :user2) OR
       (user_one_id = :user2 AND user_two_id = :user1)",
      user1: user1_id, user2: user2_id).first
  end

  def self.friends?(user1_id, user2_id)
    relationship = FriendRequest.relationship_between(user1_id, user2_id)
    relationship && relationship.status.message == "Accepted"
  end


end
