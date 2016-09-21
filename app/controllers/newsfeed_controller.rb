class NewsfeedController < ApplicationController

  def index
    @posts = current_user.friends_posts
    @comment = current_user.comments_written.new
  end

end
