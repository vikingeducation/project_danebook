class PostsController < ApplicationController

  before_action :find_user
  before_action :require_current_user, only: [:create, :destroy]

  def index
    @posts = @user.posts
    @profile = @user.profile 
    @new_post = Post.new(author: @user)
  end

  def create
    @post = Post.new(whitelist_post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:success] = "Posted on timeline."
    else
      flash[:notice] = "Didn't post."
    end
      redirect_to user_posts_path(current_user)
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



    def find_user
      @user=User.find(params[:user_id])
    end

    def require_current_user
      #In case cookies were deleted
      if current_user.nil? || User.find(current_user.id).nil?
        flash[:failure]= "Please login first"
        redirect_to root_path 
      end

      unless current_user == @user
        flash[:notice] = "You can not do this."
        redirect_to user_posts_path(@user)
      end
    end

    def whitelist_post_params
      params.require(:post).permit(:user_id,:body)
    end

end
