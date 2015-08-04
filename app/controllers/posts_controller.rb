class PostsController < ApplicationController
  before_action :find_user
  before_action :require_current_user, only: [:create, :destroy]

  def index
    @posts = @user.written_posts
    @new_post = Post.new(author: @user)
  end

  def create
    @post = Post.new(whitelist_post_params)
    if @post.save
      flash[:success] = "Successfully posted to your timeline!"
      redirect_to user_posts_path(current_user)
    else
      flash[:notice] = "Couldn't post to your timeline..."
      redirect_to user_posts_path(current_user)
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:success] = "Post deleted Successfully!"
      redirect_to user_posts_path(current_user)
    else
      flash[:notice] = "Couldn't delete post, try again."
      redirect_to user_posts_path(current_user)
    end
  end


  private

    def require_current_user
      unless current_user == @user
        flash[:notice] = "You cannot perform this action as a different user."
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
