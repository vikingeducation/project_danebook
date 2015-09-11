class NewsfeedController < ApplicationController\

  def index
    @user = User.find(params[:user_id]) if params[:user_id]
    @user ||= current_user
    @posts = @user.posts.includes(:likes)
                        .order(created_at: :desc)
    @post = Post.new
    @like = Like.new
  end

end
