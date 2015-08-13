class PostsController < ApplicationController

  before_action :require_login
  before_action :require_current_user, :except => [:index]

  def index
    @posts = Post.where("user_id = ?", params[:user_id]).
                  includes(:likes, :comments => [:likes, :user])
    @post = Post.new

    # currently doubling as timeline,
    # will separate to timeline controller
    @user = User.find(params[:user_id])
    @photos = @user.photos
    @profile = @user.profile
  end

  def create
    @post = Post.new(params_list)
    @post.user_id = current_user.id
    if @post.save
      flash[:success] = "You created a post"
      redirect_to user_posts_path(current_user)
    else
      flash[:error] = "There was an error creating your post."
      redirect_to user_posts_path(current_user)
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if (current_user.id == @post.user_id) && @post.destroy
      flash[:success] = "Your post has been deleted!"
      redirect_to user_posts_path(current_user)
    else
      flash[:error] = "There was an error deleting your post, try again."
      redirect_to user_posts_path(current_user)
    end
  end

  private

  def params_list
      params.require(:post).permit(:title, :body, :id, :user_id )
  end
end
