class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def create
    @post = current_user.posts.build(whitelisted_params)
    if @post.save
      flash[:success] = "New post !"
      redirect_to (:back)
    else
      flash[:danger] = "Something wrong"
      redirect_to (:back)
    end
  end

  def whitelisted_params
    params.require(:post).permit(:body)
  end
end
