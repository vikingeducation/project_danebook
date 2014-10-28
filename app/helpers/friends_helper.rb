module FriendsHelper
  def friend_button(target)
    if current_user == target
      nil
    elsif current_user.friends.include?(target)
      link_to "Unfriend", friend_path(target), method: "DELETE", data: { confirm: "Are you sure you want to unfriend #{target.name}?"}, class: "btn btn-danish"
    elsif current_user.friended_users.include?(target)
      link_to "Withdraw Request", friend_path(target), method: "DELETE", class: "btn btn-danish"
    elsif current_user.users_friended_by.include?(target)
      link_to "Accept Friend Request", user_friends_path(target), method: "POST", class: "btn btn-danish"
    else
      link_to "Send Friend Request", user_friends_path(target), method: "POST", class: "btn btn-danish"
    end
  end
end
