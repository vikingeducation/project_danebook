class TimelinesController < ApplicationController

  # Require login to see content about a user
  before_action :require_login, :only => [:show]

  def show
    @user = User.find(params[:user_id])
    @post = Post.new
    @comment = Comment.new
    @posts = @user.posts_received.includes(:author, :comments => :author )
    @friends = @user.friends.includes(:profile_pic) #+ @user.users_friended_by
  end

end
