module FriendingsHelper

  def friend_buttons(user)
    if current_user.friendeds.include?(user)
      link_to "Unfriend Me", friending_path(user), method: :delete, class: "btn btn-secondary unfriend-button"
    else
      link_to "Friend Me", friendings_path(user), method: :post, class: "btn btn-primary unfriend-button"
    end
  end

end
