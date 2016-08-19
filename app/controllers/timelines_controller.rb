class TimelinesController < ApplicationController

  def index
    @user = User.find_by_id(params[:user_id])
    @activities = Activity.user_newsfeed(@user)
    @post = Post.new
    @comment = Comment.new
  end

end
