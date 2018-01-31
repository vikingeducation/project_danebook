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
    @posts ||= Post.where(user: feed_users).includes(:user, :likes, :comments).order(created_at: :DESC)
  end

  def photos
    @photos ||= Photo.where(user: feed_users).includes(:user, :likes, :comments).order(created_at: :DESC)
  end

  def feed_users
    @feed_users ||= @user.friends + [@user]
  end

  def recently_active_friends
    recently_active_user_ids = activities.first(30).pluck(:user_id).uniq - [@user.id]
    User.where(id: recently_active_user_ids).includes(:profile_pic)
  end

end
