class LikesController < ApplicationController

  include LikesHelper

  def create
    post = Post.find(params[:post_id])
    if post.likes.include_user?(current_user)
      post.likes<<Like.new(:user_id => current_user.id)
    end
   
    if post.save
      redirect_to user_posts_path(post.user)
    else
      redirect_to user_posts_path(post.user)
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    if post.likes.destroy(post.likes.where("user_id = ?", current_user.id))
      flash[:success] ="Successfully deleted like"
    else
      flash[:error] = "Didnt delete like"
    end
    redirect_to user_posts_path(post.user)
  end
end
