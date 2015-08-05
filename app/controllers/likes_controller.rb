class LikesController < ApplicationController

  include LikesHelper

  def create
    post = Post.find(params[:post_id])
    
    #if post already has a like by current user 
    #current user wont be able to add another like
    # if post.likes.where("user_id = ?", current_user.id).length < 1
    if post.likes.include_current_user?
      post.likes<<Like.new(:user_id => current_user.id)
    end
   
    if post.save
      redirect_to user_posts_path(params[:user_id])
    else
      redirect_to user_posts_path(params[:user_id])
    end
  end

  def index

  end

  def destroy
    post = Post.find(params[:post_id])
    if post.likes.destroy(post.likes.where("user_id = ?", current_user.id))
      flash[:success] ="Successfully deleted like"
      redirect_to user_posts_path(params[:user_id])
    else
      flash[:error] = "Didnt delete like"
      user_posts_path(params[:user_id])
    end
  end
end
