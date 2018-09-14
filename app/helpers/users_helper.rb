module UsersHelper

  def full_name(user)
    user.profile.first_name + " " + user.profile.last_name
  end

  def friend_list(user)
    @friends = user.friendee_ids + user.friender_ids
  end

  def friend_count(user)
    friend_list(user).count
  end

  def split_list_of_friends(user)
    friends = friend_list(user)
    unless friends.empty?
      friends.each_slice((friends.size/2.0).round).to_a
    end
  end

  def photo_count(user)
    user.photos.count
  end
  
end
