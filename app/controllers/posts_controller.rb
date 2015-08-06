class PostsController < ApplicationController

  skip_before_action :require_current_user, only: [:index]

  def index
    @user = User.includes(:profile).includes(:posts).find(params[:user_id])
    @posts = @user.posts.order(created_at: :desc)
    @post = Post.new
    @like = Like.new
  end

  def create
    @post = Post.new(whitelisted_post_params)
    if @post.save
      flash[:success] = "Posted"
    else
      flash[:error] = "Cannot post this!"
    end
    redirect_to posts_path(user_id: current_user.id)

  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:success] = "Deleted"
    else
      flash[:error] = "Indestructible"
    end
    redirect_to posts_path(user_id: current_user.id)
  end

  private

  def whitelisted_post_params
    params.require(:post).permit(:user_id, :body)
  end

end
