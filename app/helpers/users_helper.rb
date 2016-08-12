module UsersHelper

  def profile_edit_link(user)
    if current_user == user
      link_to "Edit Profile", edit_profile_path(current_user)
    end
  end

  def friending_link(user)
    unless current_user == user
      button_to "Friend #{user}", friendings_path(friend_id: user.id), method: :post
    end
  end
end
