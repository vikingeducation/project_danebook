class PostsController < ApplicationController

  before_action :set_user
  before_action :require_login
  before_action :new_post, only: [:index, :new]
  before_action :set_post, only: [:show, :destroy]

  def index
    @posts = current_user.posts
    @like = @post.likes.build
  end

  def new
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
  end

  def destroy
    if @post.user != current_user
      flash[:danger] = "You can NOT delete other user's posts"
      redirect_back(fallback_location: user_timeline_path(current_user))
    else
      if @post.destroy
        flash[:success] = "Post has been successfully deleted"
      else
        flash[:danger] = "Unable to delete post"
      end
      redirect_to user_timeline_path(current_user)
    end
  end


private

  def whitelisted_post_params
    params.require(:post).permit(:body)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def new_post
    @post = Post.new
  end

end
