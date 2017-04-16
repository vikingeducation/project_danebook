class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = current_user.likes.build(like_params)
    @poster = Post.find(params[:post_id]).user
    if @like.save
      flash[:success] = "Post liked"
    else
      flash[:error] = "You've already liked that post'"
    end
    redirect_to user_profile_path(@poster)
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, post_id: params[:post_id])
    @poster = Post.find(params[:post_id]).user
    if @like.destroy
      flash[:success] = "Unliked"
    else
      flash[:error] = "Couldn't unlike"
    end
    redirect_to user_profile_path(@poster)
  end

  private

  def like_params
    params.permit(:post_id)
  end



end
