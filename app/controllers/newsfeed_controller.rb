class NewsfeedController < ApplicationController

  def index
    @user = current_user
    @posts = Post.newsfeed_posts(@user)
    @post = current_user.posts.build
    @feed = Activity.friend_feed(@user)
  end
end
