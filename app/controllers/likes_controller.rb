class LikesController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    @like = @user.likes.build(post_id: params[:format])
    if @like.save
      flash.notice = "Like added."
      redirect_to :back
    else
      flash.notice = "Error. You've already liked this post."
      redirect_to :back
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @like = Like.find(params[:id])
    if @like.destroy
      flash.notice = "Unliked."
      redirect_to :back
    else
      flash.notice = "Error. Still liking post."
      redirect_to :back
    end
  end

end
