module FriendsHelper
  def friend_button(target, css_class=nil)
    if current_user == target
      nil
    elsif current_user.friends.include?(target)
      link_to "Unfriend", friend_path(target), method: "DELETE", data: { confirm: "Are you sure you want to unfriend #{target.name}?"}, class: css_class
    elsif current_user.friended_users.include?(target)
      link_to "Withdraw Request", friend_path(target), method: "DELETE", class: css_class
    elsif current_user.users_friended_by.include?(target)
      link_to "Accept Friend Request", user_friends_path(target), method: "POST", class: css_class
    else
      link_to "Send Friend Request", user_friends_path(target), method: "POST", class: css_class
    end
  end

  def random_friends(friends)
    if friends.count <= 6
      friends
    else
      friends.shuffle[0..5]
    end
  end
end
