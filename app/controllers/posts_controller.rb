class PostsController < ApplicationController
before_action :require_authorized_user, :except => [:index]
  def index
    #show all the user's posts
    #redirect to new if authorized_user
    @user = User.find(params[:user_id])
    @posts = @user.posts.order(updated_at: :desc)
    @profile = @user.profile 
    if params[:user_id] == current_user.id.to_s
      redirect_to new_user_post_path(current_user)
    end
  end

  def new
    #everything in index, plus a form to make a new post
    @user = current_user
    @profile = @user.profile
    @posts = @user.posts.order(updated_at: :desc)
    @post = @user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to new_user_post_path(current_user)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to new_user_post_path(current_user)
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
