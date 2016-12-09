class PostsController < ApplicationController

  before_action :require_login

  def new
  end

  def create
    @user = current_user
    @post = @user.posts.build(whitelisted_params)
    if @post.save
      flash[:success] = "Post saved"
      redirect_to user_posts_path
    else
      flash.now[:error] = @post.errors.full_messages
      render :index
    end
  end

  def index
    @user = current_user
    @posts = @user.posts.reversed
    @post = @user.posts.build
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
    @user = current_user
    @post = @user.posts.find(params[:id])
    if @post.destroy
      flash[:success] = "Post deleted"
      redirect_to user_posts_path
    else

    end
  end

  private

  def whitelisted_params
    params.require(:post).permit(:content, :id)
  end

end
