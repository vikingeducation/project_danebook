module FriendingsHelper

  def display_friend_button(user)
    str = ""
    if current_user == user
      str += ""
    elsif current_user.friends.include?(user)
      str += link_to 'Unfriend Me', friending_path(id: user.id), method: :delete
    else
      str += link_to 'Friend Me', friendings_path(id: user.id), method: :post
    end
    str.html_safe
  end

end
