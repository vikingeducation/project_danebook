module FriendsHelper
  def friend_button(target)
    if current_user.friends.include?(target)
      link_to "Unfriend", friend_path(target), method: "DELETE", data: { confirm: "Are you sure you want to unfriend #{target.name}?"}
    elsif current_user.friended_users.include?(target)
      link_to "Withdraw Request", friend_path(target), method: "DELETE"
    elsif current_user.users_friended_by.include?(target)
      link_to "Accept Friend Request", user_friends_path(target), method: "POST"
    else
      link_to "Send Friend Request", user_friends_path(target), method: "POST"
    end
  end
end
