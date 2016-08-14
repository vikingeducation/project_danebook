module UsersHelper

  def profile_edit_link(user)
    if current_user == user
      link_to "Edit Profile", edit_profile_path(current_user)
    end
  end

  def friending_link(user)
    unless current_user == user
      if current_user.friended_users.where(id: user.id).empty?
        button_to "Friend #{user}", friendings_path(friend_id: user.id), method: :post
      else
        button_to "Unfriend #{user}", friending_path(friend_id: user.id), method: :delete
      end
    end
  end
end
