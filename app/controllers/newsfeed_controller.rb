class NewsfeedController < ApplicationController

  def index
    @user = current_user
    @post = Post.new
    @posts = Post.where(:user_id => @user.friended_users.pluck(:id)).order(updated_at: :desc)
    

  end
end
