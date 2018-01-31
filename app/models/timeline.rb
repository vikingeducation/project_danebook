class Timeline < ActivityStream

  def posts
    @posts ||= Post.display_in_activity(@user)
  end

  def photos
    @photos ||= Photo.display_in_activity(@user)
  end

end
