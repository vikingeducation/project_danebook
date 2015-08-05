class TimelinesController < ApplicationController

  # Require login to see content about a user
  before_action :require_login, :only => [:show]
  # before_action :require_current_user, :only => [:show]

  def show
    @post = Post.new
    @comment = Comment.new
    @posts = current_user.posts.includes(:likes, :comments => [:likes, :author] )
  end

end
