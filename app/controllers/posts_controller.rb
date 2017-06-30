class PostsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.order('created_at DESC')
    @post = @user.posts.build if signed_in_user?
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save!
      flash[:success] = "You have created new post"
      redirect_to [@user, @post]
    else
      flash[:danger] = "Something went wrong! No post created!"
      render :index
    end
  end

  private
  def post_params
    params.require(:post).permit(:body)
  end



end
