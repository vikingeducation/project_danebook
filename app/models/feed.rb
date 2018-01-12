class Feed

  attr_reader :user, :post

  def initialize(user_id:)
    @user = User.find(user_id)
    @post = @user.authored_posts.new
  end

  def posts
    @posts ||= Post.where(user: @user.friends).order(created_at: :DESC)
  end

end
