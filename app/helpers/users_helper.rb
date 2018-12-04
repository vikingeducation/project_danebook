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

  def friends_recent_posts(user)
    friends = friend_list(user)
    posts = []
    friends.each do |id|
      friend = User.find(id)
      posts << friend.posts.where(["updated_at >= ?", 7.days.ago])
    end
    posts.flatten.empty? ? nil : posts.flatten.sort_by(&:updated_at).reverse
  end

  def active_user(user_id)
    Post.exists?(["updated_at >= ? AND user_id = ?", 7.days.ago, user_id])
  end

  def recently_active_friends(user)
    friends = friend_list(user)
    active_friends = []
    friends.each do |friend_id|
      if active_user(friend_id)
        active_friends << friend_id
      end
    end
    active_friends
  end


end
