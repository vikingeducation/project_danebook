module FriendingsHelper

  def all_friends(user)
    user.friended_users.count + user.users_friended_by.count
  end


end
