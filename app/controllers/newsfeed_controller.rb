class NewsfeedController < ApplicationController

  def index
    @user = current_user
    @posts = Activity.newsfeed(@user).paginate(page: params[:page], per_page: 10)
    @post = current_user.posts.build
    @feed = Activity.recently_active(@user)
  end
end
