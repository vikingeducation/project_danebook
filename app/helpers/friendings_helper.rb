module FriendingsHelper

  def friend_unfriend_button(friend_id = params[:user_id])
    friended = current_user.friended_users.
                            find_by_id(friend_id)

    # #if friended by, still considered friend by button (not in db)
    # friended ||= current_user.users_friended_by.
    #                           find_by_id(friend_id)
    if friended
      link_to "Remove Friend", friending_path(friended.id, :friend_id => friend_id), method: :delete, class: "btn btn-info btn-lg", id: "friending"
    else
      link_to "Friend Me", friendings_path(:friend_id => friend_id), method: :post, class: "btn btn-info btn-lg", id: "friending"
    end
  end
end
