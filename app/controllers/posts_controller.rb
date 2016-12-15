class PostsController < ApplicationController

  skip_before_action :require_login, only: [:show, :index]
  before_action :require_current_user, :only => [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(whitelisted_params)
    if @post.save
      flash[:success] = "Post created!"
    else
      flash[:error] = "Try again"
    end
    redirect_to user_timeline_path
  end

  def edit
  end

  def show

  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_timeline_path
  end

  def update
  end


  private

    def whitelisted_params
      params.require(:post).permit(:body)
    end

end
