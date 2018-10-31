class PostsController < ApplicationController

  before_action :set_user
  before_action :require_login

  def index
    @posts = current_user.posts
    @post = Post.new
    @like = @post.likes.build
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(whitelisted_post_params)
    if @post.save
      flash[:success] = "Congrats! You've successfully created a post"
      redirect_to user_timeline_path(current_user)
    else
      flash[:danger] = "Unable to create your post"
      render :index
    end
  end

  def show
    set_post
  end

  def destroy
    set_post
    if @post.user != current_user
      flash[:danger] = "You can NOT delete other user's posts"
      redirect_back(fallback_location: user_timeline_path(current_user))
    else
      if @post.delete
        flash[:success] = "Post has been successfully deleted"
        redirect_to user_timeline_path(current_user)
      else
        flash[:danger] = "Unable to delete post"
        redirect_to user_timeline_path(current_user)
      end
    end
  end


private

  def whitelisted_post_params
    params.require(:post).permit(:body)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
