class NewsfeedController < ApplicationController
  layout "search"

  def index
    @user = current_user
    @post = current_user.posts.new
    @posts = Post.newsfeed(current_user)
  end
end
