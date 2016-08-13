class PostsController < ApplicationController

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post Created!"
    else
      flash[:danger] = "Please enter something!"
    end
    redirect_to current_user
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    if @post.destroy
      flash[:success] = "Post deleted!"
    else
      flash[:danger] = "Post could not be deleted!"
    end
    redirect_to current_user
  end

  private

  def post_params
    params.
      require(:post).
      permit(:text)
  end
end
