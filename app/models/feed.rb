class Feed < ActivityStream

  def posts
    @posts ||= Post.display_in_activity(feed_users)
  end

  def photos
    @photos ||= Photo.display_in_activity(feed_users)
  end

  def feed_users
    @feed_users ||= @user.friends + [@user]
  end

end
