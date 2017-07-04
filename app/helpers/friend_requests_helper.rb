module FriendRequestsHelper
  def friend_action_button(user, cls="btn btn-primary btn-small")
    # check current_user isn't looking at his page
    if signed_in_user? && (user.id != current_user.id)
      friendship = current_user.relationship_with(user.id)
      # are they:
      # not friends
      if friendship.nil?
        add_friend_button(user, cls)
      # friends
      elsif friendship.status.message == "Accepted"
        remove_friend_button(friendship, cls)
      elsif friendship.status.message == "Pending"
        # current user sent friend request and is awaiting response
        if current_user == friendship.initiator
          cancel_request_button(friendship, cls)
        # user awaiting current_user confirmation
        else
          confirm_request_button(friendship, cls)
        end
      else
        # sanity check
        button_tag "You are #{friendship.status.message}!"
      end
    end
  end

  def add_friend_button(user, cls)
    link_to "Add as Friend",
            friend_requests_path(user_id: user.id),
            {class: cls,
             method: :post}
  end

  def remove_friend_button(friendship, cls)
    link_to "Remove Friend",
            friend_request_path(friendship.id),
            {class: cls,
             method: :delete}
  end

  def cancel_request_button(friendship, cls)
    link_to "Cancel Friend Request",
            friend_request_path(friendship.id),
            {class: cls,
             method: :delete}
  end

  def confirm_request_button(friendship, cls)
    link_to "Confirm Friend Request",
            friend_request_path(friendship.id),
            {class: cls,
             method: :put}
  end
end
