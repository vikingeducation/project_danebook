module FriendingsHelper

  def friend_unfriend_button
    friended = current_user.initiated_friendings.
                  find_by_friend_id(params[:user_id])
    if friended
      link_to "Remove Friend", friending_path(friended.id, :friend_id => params[:user_id]), method: :delete, class: "btn btn-info btn-lg", id: "friending"
    else
      link_to "Friend Me", friendings_path(:friend_id => params[:user_id]), method: :post, class: "btn btn-info btn-lg", id: "friending"
    end
  end
end
