class PostsController < ApplicationController

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

  private
    def strong_post_params
      p params
      params.require(:post).permit(:body, :user_id)
    end

end
