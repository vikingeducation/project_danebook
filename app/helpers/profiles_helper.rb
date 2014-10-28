module ProfilesHelper
  def edit_profile_button(user, css_class=nil)
    if current_user && user == current_user
      link_to 'Edit Profile', edit_user_profile_path(user), class: css_class
    end
  end
end
