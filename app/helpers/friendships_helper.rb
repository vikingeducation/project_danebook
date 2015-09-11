module FriendshipsHelper

  def friend_count(friend)
    friend.accepted_friends.count
  end

  def display_friend_count(friend)
    total = friend_count(friend)
    total == 1 ? total.to_s + " Friend" : total.to_s + " Friends"
  end

  def display_friend_info(friendship)
    if friendship.friend_acceptor == object_owner
      link_to(friendship.friend_initiator.full_name,
              user_posts_path(user_id: friendship.friend_initiator.id)) +
              "<br>".html_safe +
              display_friend_count(friendship.friend_initiator)
    else
      link_to(friendship.friend_acceptor.full_name,
              user_posts_path(user_id: friendship.friend_acceptor.id)) +
              "<br>".html_safe +
              display_friend_count(friendship.friend_acceptor)
    end
  end

  def display_button(friendship)
    if object_owner?
      link_to("Unfriend Me", user_friendship_path(:id => friendship.id, :user_id => current_user.id),
              class: "btn btn-default active btn-sm pull-right", method: :delete)
    elsif friendship.is_you?(current_user, object_owner)
      content_tag(:div, 'This Is You', class:['btn', 'btn-danger', 'btn-sm', 'pull-right'])
    elsif friendship.is_a_friend?(current_user)
      content_tag(:div, 'Your Friend', class:['btn', 'btn-default', 'btn-sm', 'pull-right'])
    else
      link_to("Add Friend",
      user_friendships_path(:user_id => friend_to_add(friendship)),
      class: "btn btn-primary btn-sm pull-right", method: :post)
    end
  end

  def friend_to_add(friendship)
    friendship.friend_initiator == object_owner ?
    friendship.friend_acceptor.id : friendship.friend_initiator.id
  end

  # For Pending Friendships

  def display_pending_friend_info(friendship)
      link_to(friendship.friend_initiator.full_name,
              user_posts_path(user_id: friendship.friend_initiator.id)) +
              "<br>".html_safe +
              display_friend_count(friendship.friend_initiator)
  end

  def display_confirm_button(friendship)
    link_to("Confirm Friend",
            user_friendship_path( :id => friendship.id,
                          :user_id => current_user.id),
            class: "btn btn-success active btn-sm pull-right",
            method: :put)
  end

  # For displaying the right thumbnail

  def user_thumb_to_display(friendship)
    friendship.friend_initiator == object_owner ?
    friendship.friend_acceptor : friendship.friend_initiator
  end

  # Display friend button or not in header

  def display_add_friend_button()
    if !object_owner?
      if ( !is_obj_owner_an_accepted_friend? &&
           !is_obj_owner_a_pending_friend? )
        link_to("Add Friend",
                user_friendships_path(:user_id => object_owner.id),
                class: "btn btn-primary btn-sm pull-right",
                method: :post)
      end
    end
  end

  def is_obj_owner_an_accepted_friend?()
    result = false
    current_user.accepted_friends.each do |friendship|
      if (friendship.initiator_id == object_owner.id ||
          friendship.acceptor_id  == object_owner.id)
        result = true
      end
    end
    result
  end

  def is_obj_owner_a_pending_friend?()
    result = false
    current_user.pending_friends.each do |friendship|
      if (friendship.initiator_id == object_owner.id ||
          friendship.acceptor_id  == object_owner.id)
        result = true
      end
    end
    return result
  end

end