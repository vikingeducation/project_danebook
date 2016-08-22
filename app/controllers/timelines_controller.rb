class TimelinesController < ApplicationController
  before_action :required_user_redirect

  def index
    @user = User.find_by_id(params[:user_id])
    @activities = Activity.user_newsfeed(@user)
    @post = Post.new
    @comment = Comment.new
    render layout: "newsfeed_topper"
  end

end
