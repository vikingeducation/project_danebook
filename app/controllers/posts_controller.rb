class PostsController < ApplicationController
  before_action :require_current_user, :only => [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "Post created!"
      redirect_to timeline_path(current_user)
    else
      flash[:error] = "Unable to create post"
      redirect_to timeline_path(current_user)
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:success] = "Post deleted!"
      redirect_to timeline_path(current_user)
    else
      flash[:error] = "Unable to delete post!"
      redirect_to timeline_path(current_user)
    end
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :body, :created_at, :updated_at)
  end
end
