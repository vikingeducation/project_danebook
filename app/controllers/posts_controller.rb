class PostsController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    @user.posts.build(post_params)
    if @user.save
      flash.notice = "Post created."
      redirect_to user_timeline_path(@user)
    else
      flash.notice = "Error. Post not created."
      redirect_to user_timeline_path(@user)
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    if @post.destroy
      flash.notice = "Post deleted."
      redirect_to user_timeline_path(@user)
    else
      flash.notice = "Error. Post not deleted."
      redirect_to user_timeline_path(@user)
    end
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end

end
