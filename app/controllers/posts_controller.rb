class PostsController < ApplicationController
  layout "timeline"

  before_action :require_login


  def index
    @posts = Post.find_by_user_id(params[:user_id])
    @new_post = Post.new
  end


  def create
    @post = Post.new(whitelisted_params)
    @post.user_id = current_user.id
    if @post.save 
      flash[:success] = "Post created"
    else
      flash[:error] = "Unable to save post"
    end
    redirect_to user_timeline_path(current_user)
  end


  def destroy
    @post = Post.find(params[:id])
     if @post.destroy 
      flash[:success] = "Post deleted"
    else
      flash[:error] = "Unable to delete post"
    end
    redirect_to user_timeline_path(current_user)
  end




  private
  def whitelisted_params
    params.require(:post).permit(:body)
  end


end
