module FriendsHelper

  def friend_button(user)
    if current_user.friends?(user.id)
      link_to 'Remove as Friend', user_friend_path(id: current_user.id), method: "DELETE", class: 'btn btn-large btn-info friend-button'
    else
      link_to 'Add as Friend', user_friends_path(user_id: user.id), :method => :post, class: 'btn btn-large btn-info friend-button'
    end
  end

end
