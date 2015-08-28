class NewsfeedsController < ApplicationController

  before_action :require_login

  def show
    @user = current_user
    @posts = Post.get_newsfeed_posts(@user.friended_user_ids)
    @friends = User.get_recently_active_friends(@posts)
  end

end
