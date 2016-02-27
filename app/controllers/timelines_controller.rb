class TimelinesController < ApplicationController

  # Require login to see content about a user
  before_action :require_login, :only => [:show]

  def show
    @user = User.find(params[:user_id])
    @post = Post.new
    @comment = Comment.new
    @posts = @user.posts_received.includes( author: :profile_pic,
                                            comments: :author,
                                            likes: :user )
    @friends = @user.friends.includes(:profile_pic)
  end

end
