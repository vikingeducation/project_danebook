class NewsfeedsController < ApplicationController
  def show
    @user = current_user
    @posts = Newsfeed.gather_posts(@user)
  end
end
