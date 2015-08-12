module ApplicationHelper

  def bootstrap_class_for(flash_type)
    case flash_type
    when "success"
      "alert-success"
    when "error"
      "alert-danger"
    when "alert"
      "alert-warning"
    when "notice"
      "alert-info"
    else
      flash_type.to_s
    end
  end

  def navbar_display

    if signed_in_user?
      render partial: "shared/signed_in_navbar"
    else
      render partial: "shared/signed_out_navbar"
    end
  end

  def edit_or_friend_link
    if (params[:user_id]==current_user.id.to_s && (controller.class != ProfilesController && controller.action_name != "edit"))
          link_to "Edit Profile", edit_user_profile_path(current_user)
    elsif current_user.id.to_s != params[:user_id]
      friend_unfriend_button
    end
  end

  def page_owner
    User.find(params[:user_id])
  end

end
