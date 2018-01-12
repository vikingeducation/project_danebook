class Timeline

  attr_reader :user, :posts, :post, :friends #, :photos

  def initialize(user_id:)
    @user = User.find(user_id)
    @posts = @user.authored_posts.order(created_at: :DESC)
    @post = @user.authored_posts.new
    @friends = @user.friends.sample(9)
    # @photos = @user.photos.sample(9)
  end

end
