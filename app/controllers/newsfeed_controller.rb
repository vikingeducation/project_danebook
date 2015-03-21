class NewsfeedController < ApplicationController
  layout "search"

  def index
    @user = current_user
    @post = current_user.posts.new
    @posts = current_user.newsfeed
  end
end
