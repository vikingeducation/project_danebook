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

end

# For displaying the right thumbnail

def user_thumb_to_display(friendship)
  friendship.friend_initiator == object_owner ?
  friendship.friend_acceptor : friendship.friend_initiator
end