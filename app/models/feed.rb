class Feed

  attr_reader :user, :post

  def initialize(user_id:)
    @user = User.find(user_id)
    @post = @user.authored_posts.new
    @friends = @user.friends
  end

  def posts
    @posts ||= Post.where(user: @friends).order(created_at: :DESC)
  end

end
