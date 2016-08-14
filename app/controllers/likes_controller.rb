class LikesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @post.likes.create(user_id: current_user.id)
    redirect_to :back
  end

  def destroy
    Like.find(params[:id]).destroy
    redirect_to :back
  end

end
