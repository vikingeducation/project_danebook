class TimelinesController < ApplicationController

  # Require login to see content about a user
  before_action :require_login, :only => [:show]
  # before_action :require_current_user, :only => [:show]

  def show
    @user = User.find(params[:user_id])
    @post = Post.new
    @comment = Comment.new
    @posts = @user.posts_received.includes(:author, :likes, :comments => :author )
    @friends = @user.friended_users # + @user.users_friended_by
  end

end
