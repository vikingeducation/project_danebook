module ApplicationHelper
  def user_birthday
    @user.birthday.strftime("%B %d, %Y") || @current_user.birthday.strftime("%B %d, %Y")
  end

  def edit_or_friend
    if required_user?
      link_to "Edit Profile", edit_user_path(@current_user), class: "pull-right edit-link" if !editing_profile?
    elsif !@current_user.current_friend?(params[:user_id])
      link_to "Add Friend", get_path, method: :post, class: "pull-right edit-link"
    else
      link_to "Remove Friend", friending_path(@current_user.this_friend(params[:user_id])), method: :delete, class: "pull-right edit-link"
    end
  end

  def editing_profile?
    action_name == "edit"
  end

  def get_path
    if params[:user_id]
      user_friendings_path(params[:user_id])
    elsif params[:id]
      user_friendings_path(params[:id])
    else
      user_friendings_path(current_user.id)
    end
  end

  def friend_or_unfriend(friend)
    if !@current_user.current_friend?(friend.id)
      link_to "Friend Me", user_friendings_path(friend.id), class: "btn btn-default frd-btn", method: :post
    else
      link_to "Unfriend Me", friending_path(friend.recieved_friendings.where(initiator_id: @user.id)[0]), class: "btn btn-default frd-btn", method: :delete
    end
  end
end
