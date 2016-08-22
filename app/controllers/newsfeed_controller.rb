class NewsfeedController < ApplicationController
  def show
    @all_posts = current_user.newsfeed_posts(10)
    @recent_friends = current_user.newsfeed_friends
    @user = current_user
    @post = @user.posts.build
  end
end
