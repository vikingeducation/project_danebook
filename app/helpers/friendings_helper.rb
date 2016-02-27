module FriendingsHelper

  def friend_unfriend_button(friend_id = params[:user_id])
    friended = current_user.friended_users.
                            find_by_id(friend_id)

    # #if friended by, still considered friend by button (not in db)
    # friended ||= current_user.users_friended_by.
    #                           find_by_id(friend_id)
    if friended
      link_to "Remove Friend", friending_path(friended.id, :friend_id => friend_id), method: :delete, class: "btn btn-default btn-lg", id: "friending"
    else
      link_to "Friend Me", friendings_path(:friend_id => friend_id), method: :post, class: "btn btn-info btn-lg", id: "friending"
    end
  end

  def friend_num
    num = User.find(params[:user_id]).friends.size
    num > 0 ? "(#{num.to_s})"  : ""
  end

  #if no friends, do not display widget on timeline
  def friends_widget
    if @user.friends.any?
      render partial: 'friend_panel', locals: {friends: @user.friends.shuffle}
    end
  end
end
