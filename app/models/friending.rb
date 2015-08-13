  class Friending < ActiveRecord::Base

    # being intiated into friendships
    belongs_to :friend_initiator, :foreign_key => :friender_id,
                                  :class_name => "User"

    # being reciepient of friendships
    belongs_to :friend_recipient, :foreign_key => :friend_id,
                                  :class_name => "User"

      #make sure friendships are unique
    validates :friend_id, :uniqueness => { :scope => :friender_id }


  def self.friendship_exists?(current_user, friend)
    !(find_by_friend_id_and_friender_id(current_user, friend)).nil?
  end

  def self.request_friend(current_user, friend)
    unless current_user == friend || friendship_exists?(current_user, friend)
      transaction do 
        Friending.create(
          :friender_id => current_user.id, :friend_id => friend.id, :status => 'pending')
        Friending.create(
          :friend_id => friend.id, :friender_id => current_user.id, :status => 'requested')
      end
    end
  end

  def self.friendship_accept(current_user, friend)
    transaction do

      (find_by_friend_id_and_friender_id(current_user, friend).status = "accepted").save!
      (find_by_friend_id_and_friender_id(friend, current_user).status = "accepted").save!
    end
  end

  def self.friendship_destroy(current_user, friend)
    transaction do
     destroy(find_by_friend_id_and_friender_id(current_user, friend))
     destroy(find_by_friend_id_and_friender_id(friend, current_user))
    end
  end
  
  def self.pending_friend_requests
    friendships = self.friendships.where(user_id: self.id, status: 'requested')
    return User.find(friendships.map(&:friend_id))
  end

  

end
