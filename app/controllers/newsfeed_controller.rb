class NewsfeedController < ApplicationController

  before_action :require_current_user, :only => [:index]

  
  def index
    @user = current_user
    @post = Post.new
    @posts = Post.posts_of_friended_users(@user)
  end

end
