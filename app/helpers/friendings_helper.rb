module FriendingsHelper
   def count_user_friends(user)
    user.users_friended_by.count
  end

  def is_friend?(user)
    cu_friends = current_user.friended_users.pluck(:id)
    cu_friends.include?(user.id)
  end
end
