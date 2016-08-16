class LikingsController < ApplicationController

  def index
    redirect_to user_path(current_user)
  end

  def create
    @post = Post.find(params[:post_id])
    @post.likes.create(user_id: current_user.id)
    redirect_to user_path(current_user)
  end

  def destroy
    @liking = Liking.find(params[:id])
    @post = @liking.likeable
    @user = @liking.user
    if @liking.destroy
      redirect_to user_path(current_user)
    else
      redirect_to user_path(current_user)
    end
  end
end
