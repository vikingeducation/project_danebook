class PostsController < ApplicationController
  before_action :set_post, only: [:show, :destroy]
  before_action :set_post_user_profile, only: [:index, :create, :new]
  before_action :require_login
  before_action :require_current_user, :only => [:new, :create, :update, :destroy]

  def index
    @posts = @user.recent_posts
    render :new
  end

  def new
    @posts   = @user.recent_posts
    @post    = @user.posts.build
  end  

  def create

    @post = @user.posts.build(post_params)

    if @post.save
      flash[:success] = "Post saved!"
      redirect_to new_user_post_path(params[:user_id])
    else
      flash[:alert] = "Post not saved!"
      redirect_to new_user_post_path(params[:user_id])
    end
  end  

  def show

  end 

  def destroy
    if @post.destroy
      flash[:success] = "Post deleted!"
      redirect_to new_user_post_path(params[:user_id])
    else
      flash[:alert] = "Post not deleted!"
      redirect_to new_user_post_path(params[:user_id])
    end
  end

  private

  def set_post_user_profile
    @user = User.find(params[:user_id])

    @profile = @user.profile 
    puts "GOT HERE in for user_ID #{@user.id} AND PROFILE #{@profile}"
  end
    
  def set_post
    @post = Post.find(params[:id])
    @user = @post.user
    @profile = @user.profile
    @like = @post.likes.where("user_id = ?",current_user.id)
  end

  def post_params

    params.require(:post).permit(
      :id,
      :user_id,
      :body
    )
  end
end