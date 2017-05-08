class NewsfeedController < ApplicationController

  def index
    @user = current_user
    @posts = Post.newsfeed_posts(@user).paginate(page: params[:page], per_page: 10)
    @post = current_user.posts.build
    @feed = Activity.friend_feed(@user)
  end
end
