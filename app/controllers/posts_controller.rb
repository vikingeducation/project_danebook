class PostsController < ApplicationController

  def show
  end

  def create
    @post = current_user.posts.build
    if @post.save
      flash.now[:success] = "Post Created!"
      render current_user
    else
      flash.now[:danger] = "Please enter something!"
      render current_user
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    if @post.destroy
      flash.now[:success] = "Post deleted!"
      render current_user
    else
      flash.now[:danger] = "Post could not be deleted!"
      render current_user
    end
  end

  private

  def post_params
    params.
      require(:post).
      permit(:text)
  end
end
