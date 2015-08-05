class LikesController < ApplicationController

  before_action :require_login

  def create
    post = Post.find(params[:post_id])
    like = post.likes.new

    like.user_id = current_user.id if current_user
    if like.save
      redirect_to request.referrer
    else
      flash[:error] = "Could not like this post. Please try again"
      redirect_to request.referrer
    end
  end

  def destroy
    like = Like.find(params[:id])
    like.destroy
    redirect_to request.referrer
  end

  private

  def require_login
    unless current_user
      flash[:error] = "You must be logged in"
      redirect_to root_path # halts request cycle
    end
  end

end
