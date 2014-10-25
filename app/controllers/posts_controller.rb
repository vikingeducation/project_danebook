class PostsController < ApplicationController

  before_action :require_current_user, except: [:index]
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts

    @post = current_user.posts.build if @user == current_user
  end


  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to user_posts_url(current_user)
    else
      flash[:error] = "Failed to post."
      render :index
    end
  end

  private

  def post_params
    params.require(:post).permit(:body, :user_id)
  end
end
