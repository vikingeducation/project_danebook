module FriendshipsHelper

  def show_friend_or_unfriend(user)
    if current_user.friends.include?(user)
      show_unfriend(user)
    else
      show_friend(user)
    end
  end

  def show_unfriend(user)

    link_to("Remove Friend", friendship_path(:friend_id => user),
                             :method => :delete,
                             class: "btn btn-primary pull-right")
  end

  def show_friend(user)
    link_to("Add Friend", friendships_path(:friend_id => user),
                          :method => :post,
                          class: "btn btn-primary pull-right")
  end

end
