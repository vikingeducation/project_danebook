class NewsfeedsController < ApplicationController

  def index
    @user = current_user
    @post = current_user.posts.build
    @posts = current_user.newsfeed_posts
    @friends = get_friends(@posts)
  end

  private

  def get_friends(posts)
    ids = posts.pluck(:user_id).uniq
    friends = ids.map { |id| User.find(id) }
  end

end
