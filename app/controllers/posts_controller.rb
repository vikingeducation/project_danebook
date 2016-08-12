class PostsController < ApplicationController

  def show
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post Created!"
      redirect_to current_user
    else
      flash[:danger] = "Please enter something!"
      redirect_to current_user
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    if @post.destroy
      flash[:success] = "Post deleted!"
      redirect_to current_user
    else
      flash[:danger] = "Post could not be deleted!"
      redirect_to current_user
    end
  end

  private

  def post_params
    params.
      require(:post).
      permit(:text)
  end
end
