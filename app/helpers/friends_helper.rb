module FriendsHelper

  def friend_unfriend_button(friend)
    if friend == current_user
      "(this is you!)"
    elsif current_user.friended_users.include?(friend)
      link_to "Unfriend", user_friend_path(current_user, friend), method: 'delete', class: "btn btn-danger btn-block", alt: "Unfriend #{friend.profile.full_name}"
    else
      link_to "Friend Me", user_friends_path(current_user, :recipient_id => friend.id), method: 'post', class: "btn btn-primary btn-block", alt: "Add #{friend.profile.full_name} as a Friend"
    end
  end

end
