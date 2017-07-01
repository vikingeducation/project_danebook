class PostsController < ApplicationController

  before_action :require_current_user => [:create, :destroy]

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.order('created_at DESC')
    @post = @user.posts.build if signed_in_user?
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save!
      flash[:success] = "You have created new post"
      redirect_to user_timeline_path
    else
      flash[:danger] = "Something went wrong! No post created!"
      render :index
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:success] = "You have deleted post successfully!"
      redirect_to user_timeline_path
    else
      flash.now[:danger] = "Deleting post didn't work :("
      render :index
    end
  end

  private
  def post_params
    params.require(:post).permit(:body)
  end



end
