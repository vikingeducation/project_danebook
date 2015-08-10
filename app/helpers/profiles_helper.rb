module ProfilesHelper

  def edit_link_display
    if current_user.id == @user.id
      str = link_to "Edit Your Profile", edit_user_profile_path(current_user), class: "btn btn-active", id: "edit-profile"
      str.html_safe
    end
  end

end
