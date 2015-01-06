module FriendsHelper
  def friend_button(target)
    css_class = "btn btn-danish pull-right"

    if current_user.friends.include?(target)
      label, method, action = "Unfriend", "DELETE", :destroy
    elsif current_user.friended_users.include?(target)
      label, method, action = "Withdraw Request", "DELETE", :destroy
    elsif current_user.users_friended_by.include?(target)
      label, method, action = "Accept Friend Request", "POST", :create
    else
      label, method, action = "Send Friend Request", "POST", :create
    end

    unless current_user == target
      link_to label,
              url_for(controller: 'friends', id: target.id, action: action),
              method: method,
              remote: true,
              class: css_class, id: "friend-#{target.id}"
    end
  end

  def decline_button(target, css_class=nil)
    if current_user.friend_requests.include?(target)
      link_to "Decline", friend_path(target), method: "DELETE", data: { confirm: "Are you sure you want to decline #{target.name}'s friend request?"}, class: css_class
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
