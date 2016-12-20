module FriendingsHelper

  def friend_count(user_id)
    User.find(user_id).users_friended_by.count
  end

end
