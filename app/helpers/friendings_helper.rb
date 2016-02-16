module FriendingsHelper

  def all_friends_count(user)
    user.friended_users.count + user.users_friended_by.count
  end


  def all_friends(user)
    user.friended_users + user.users_friended_by
  end



end
