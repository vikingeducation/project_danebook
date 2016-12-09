class PostsController < ApplicationController
  before_action :require_login
  before_action :require_current_user, only: [:create, :update, :destroy]

  def index
    @user = User.find(params[:user_id])
    @profile = @user.profile
    @post = current_user.posts.build
    @posts = @user.posts
  end

  def show

  end

  def create
    @post = current_user.posts.build(strong_post_params)
    if @post.save
      flash[:success] = "Post published!"
      redirect_to user_posts_path(current_user)
    else
      flash[:warning] = @post.errors.full_messages
      @profile = User.find(params[:user_id]).profile
      render :index
    end
  end

  def destroy
    @post = current_user.posts.find(params[:post_id])
    if @post.destroy
      flash[:success] = "Post deleted!"
      redirect_to user_posts_path(current_user)
    else
      flash[:warning] = @post.errors.full_messages
      redirect_to user_posts_path(current_user)
    end
  end

  private
    def strong_post_params
      p params
      params.require(:post).permit(:body, :user_id)
    end

end
