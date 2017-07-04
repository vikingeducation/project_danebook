class StaticPagesController < ApplicationController
  before_action :require_current_user, only: [:newsfeed]

  def home
    if signed_in_user?
      redirect_to user_newsfeed_path(current_user)
    else
      redirect_to new_user_path
    end
  end

  def newsfeed
    @user = User.find(params[:user_id])
    @post = current_user.posts.build
    @friend_ids = @user.friends.map(&:id)
    @posts = Post.where(user_id: @friend_ids).order(:created_at => :desc).limit(5)
  end

end
