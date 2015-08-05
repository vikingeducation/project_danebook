module ApplicationHelper
  def edit_or_sign_up_button
    if current_user
      str =  link_to 'Edit Your Profile', edit_profile_path( current_user.profile, class: 'btn btn-primary btn-sm pull-right')
    else
      str = link_to('Sign Up', new_user_path, class: 'btn btn-primary btn-sm pull-right')
    end
    str.html_safe
  end

  def edit_or_sign_up
    if current_user
      str =  link_to 'Edit Your Profile', edit_profile_path( current_user.profile)
    else
      str = link_to('Sign Up', new_user_path)
    end
    str.html_safe
  end
end
