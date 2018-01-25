class Feed

  attr_reader :user, :post, :photo

  def initialize(user_id:)
    @user = User.find(user_id)
    @post = @user.authored_posts.new
    @photo = @user.photos.new
  end

  def activities
    @activities ||= [posts.to_a, photos.to_a].flatten.sort_by { |a| a[:created_at] }.reverse!
  end

  def posts
    @posts ||= Post.where(user: feed_users).order(created_at: :DESC)
  end

  def photos
    @photos ||= Photo.where(user: feed_users).order(created_at: :DESC)
  end

  def feed_users
    @feed_users ||= @user.friends + [@user]
  end

end
