class PostsController < ApplicationController

  before_action :find_user
  before_action :require_current_user, only: [:create, :destroy]

  def index
    @posts = @user.posts
     @profile = Profile.find_by_user_id(params[:user_id])
    @new_post = Post.new(author: @user)
  end

  def create
    @post = Post.new(whitelist_post_params)
    if @post.save
      flash[:success] = "Posted on timeline."
      redirect_to user_posts_path(current_user)
    else
      flash[:notice] = "Didn't post."
      redirect_to user_posts_path(current_user)
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:success] = "Post deleted."
      redirect_to user_posts_path(current_user)
    else
      flash[:notice] = "Not deleted, try again."
      redirect_to user_posts_path(current_user)
    end
  end


  private

    def require_current_user
      unless current_user == @user
        flash[:notice] = "You can not do this."
        redirect_to user_posts_path(@user)
      end
    end

    def find_user
      @user = User.includes(:profile).find(params[:user_id])
    end

    def whitelist_post_params
      params.require(:post).permit(:user_id, :body)
    end

end
