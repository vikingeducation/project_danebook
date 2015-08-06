class PostsController < ApplicationController

  before_action :require_login, :except => [:new, :create]
  before_action :require_current_user, :only => [:edit, :update, :destroy]

  def index
    @posts = Post.where("user_id = ?", params[:user_id]).includes(:comments => :likes)
    @post = Post.new
    @profile = current_user.profile
  end

  def create
    @post = Post.new(params_list)
    @post.user_id = current_user.id
    if @post.save
      redirect_to user_posts_path(current_user)
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:success] = "Your post has been deleted!"
      redirect_to user_posts_path(current_user)
    else
      flash[:danger] = "There was an error deleting your post, try again."
      redirect_to user_posts_path(current_user)
    end
  end

  private

  def params_list
      params.require(:post).permit(:title, :body, :id, :user_id )
  end
end
