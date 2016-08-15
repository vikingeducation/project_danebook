module UsersHelper

  def profile_edit_link(user)
    if current_user == user
      link_to "Edit Profile", edit_profile_path(current_user)
    end
  end
end
