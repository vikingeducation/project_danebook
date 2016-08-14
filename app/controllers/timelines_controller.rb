class TimelinesController < ApplicationController
  skip_before_action :correct_user

  def show
    @timeline = Timeline.find(params[:id])
    @user = @timeline.user
    @profile = @user.profile
    @posts = @user.posts
    @post = @posts.build
    @like = Like.new(user_id: current_user.id)
    @comment = Comment.new(user_id: current_user.id)
    @friends = @user.friends
  end

end
