class LikesController < ApplicationController

  def like_unlike
    @like = Like.find_by(user_id: params[:user_id], post_id: params[:post_id])
    if @like
      @like.destroy
      flash.now[:success] = "Post Unliked"
      redirect_to user_timeline_path(User.find(Post.find(params[:post_id]).user.id))
    else
      Like.create(whitelisted_like_params)
      flash.now[:success] = "Post liked"
      redirect_to user_timeline_path(User.find(Post.find(params[:post_id]).user.id))
    end
  end

  private

  def whitelisted_like_params
    params.permit(:user_id, :post_id)
  end

end
