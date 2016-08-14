module ApplicationHelper
  def user_birthday
    @user.birthday.strftime("%B %d, %Y") || @current_user.birthday.strftime("%B %d, %Y")
  end

  def edit_or_friend
    if required_user?
      link_to "Edit Profile", edit_user_path(@current_user), class: "pull-right edit-link" if !editing_profile?
    elsif !@current_user.current_friend?(params[:user_id])
      link_to "Add Friend", user_friendings_path(params[:user_id]), method: :post, class: "pull-right edit-link"
    else
      link_to "Remove Friend", friending_path(@current_user.this_friend(params[:user_id])), method: :delete, class: "pull-right edit-link"
    end
  end

  def editing_profile?
    action_name == "edit"
  end
end
