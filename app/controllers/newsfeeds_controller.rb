class NewsfeedsController < ApplicationController

  def index
    @user = current_user
    @post = current_user.posts.build
    @posts = current_user.newsfeed_posts
    @friends = @posts.pluck(:user_id).uniq
  end

end
