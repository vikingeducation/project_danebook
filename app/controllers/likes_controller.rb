class LikesController < ApplicationController
  def create
    if signed_in_user?
      post = Post.find(params[:post_id])
      if post.likes.create(:user_id => current_user.id)
        flash[:success] = "Like contributed to the post!"
      else
        flash[:error] = "Couldn't establish the like"
      end
      redirect_to root_path
    else
      redirect_to login_path
    end
  end

  def destroy
    if signed_in_user?
      @like = Like.find(params[:id])
      if @like.destroy
        flash[:success] = "Unliked the post"
      else
        flash[:error] = "Couldn't make the unlike"
      end
      redirect_to root_path
    else
      redirect_to login_path
    end
  end
end
