class Feed

  attr_reader :user, :post

  def initialize(user_id:)
    @user = User.find(user_id)
    @post = @user.authored_posts.new
  end

  def posts
    feed_users = @user.friends + [@user]
    @posts ||= Post.where(user: feed_users).order(created_at: :DESC)
  end

end
