class Timeline

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
    @posts ||= Post.where(user: @user).order(created_at: :DESC)
  end

  def photos
    @photos ||= Photo.where(user: @user).order(created_at: :DESC)
  end

  def photos_count
    photos.count
  end

  def sidebar_photos
    photos.sample(9)
  end

  def friends_count
    @user.friends.count
  end

  def sidebar_friends
    @user.friends.sample(9)
  end


end
