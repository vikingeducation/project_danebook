class LikesController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    @like = @user.likes.build(post_id: params[:format])
    if @like.save
      flash.notice = "Like added."
      redirect_back(fallback_location: current_user)
    else
      flash.notice = "Error. You've already liked this post."
      redirect_back(fallback_location: current_user)
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @like = Like.find(params[:id])
    if @like.destroy
      flash.notice = "Unliked."
      redirect_back(fallback_location: current_user)
    else
      flash.notice = "Error. Still liking post."
      redirect_back(fallback_location: current_user)
    end
  end

end
