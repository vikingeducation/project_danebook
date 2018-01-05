class Timeline

  attr_reader :user, :posts, :post

  def initialize(user_id:)
    @user = User.find(user_id)
    @posts = @user.posts.order(created_at: :DESC)
    @post = @user.posts.new
  end

end
