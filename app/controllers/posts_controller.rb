class PostsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(user_id: params[:user_id]).order(created_at: :desc)
    @post = current_user.posts.build if signed_in_user?
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to user_timeline_path(current_user)
    else
      flash[:error] = "Failed to post."
      render :index
    end
  end

  def show
    redirect_to user_timeline_path(params[:user_id])
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    if @post.destroy
      flash[:success] = "Post deleted."
      redirect_to user_timeline_path(current_user)
    else
      flash[:error] = "Something went wrong with this deletion."
      render :index
    end
  end

  private

    def post_params
      params.require(:post).permit(:body)
    end

end
