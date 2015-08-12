module FriendingsHelper
  
  def notfriends?(user,friend)
    Friending.where("user_id=? AND friend_id=?", user, friend).empty?

  end
end
