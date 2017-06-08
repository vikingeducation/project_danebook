class PostsController < ApplicationController
  before_action :set_user
  before_action :require_current_user, only: [:new, :create, :destroy]

  def index
    @post = Post.new
    @posts = @user.posts
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created successfully"
      redirect_to root_path
    else
      flash[:danger] = "Failed to create post"
      render "static_pages/timeline"
    end
  end

  def destroy
    post = Post.find(params[:id])
    if post.delete
      flash[:success] = "Post deleted successfully"
      redirect_to root_path
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def post_params
    params.require(:post).permit(:body)
  end

end
