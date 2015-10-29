## should Newsfeed contain my own posts?  Right now AJAX does, but not HTML version...
# what do I actually want?

class NewsfeedsController < ApplicationController

  before_action :require_login

  def show
    @user = current_user
    @posts = Post.get_newsfeed_posts(@user.friended_user_ids)
    @friends = User.get_recently_active_friends(@posts)
  end

end
