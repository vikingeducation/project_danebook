class TimelinesController < ApplicationController
  def show
    @user = current_user
    @profile = @user.profile
    @posts = @user.posts
    @post = Post.new(user_id: @user.id)
  end
end
