class PostsController < ApplicationController
  before_action :require_login, only: [:create, :destroy]

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id if current_user
    if @post.save
      flash[:success] = "You've created a post!"
    else
      flash[:danger] = "Failed to create a post!"
    end
    redirect_to user_path(current_user)
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:success] = "You've deleted a post!"
      redirect_to user_path(current_user)
    else
      flash[:danger] = "Failed to delete a post!"

    end
  end

  private

  def post_params
    params.require(:post).permit(:body, :user_id)
  end
end
