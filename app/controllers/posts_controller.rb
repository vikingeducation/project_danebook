class PostsController < ApplicationController
  before_action :set_post, only: [:show, :destroy]
  before_action :set_post_user_profile, only: [:index, :newsfeed, :create, :new]
  before_action :require_login
  before_action :require_current_user, :only => [:new, :create, :update, :destroy, :newsfeed]

  def index
    @posts = @user.recent_posts
    render :new
  end

  def newsfeed
    @post = @user.posts.build #--> Fix this
    @posts = @user.friend_posts
    render :newsfeed
  end

  def new
    @posts = @user.recent_posts
    @post  = @user.posts.build
  end  

  def create

    @post = @user.posts.build(post_params)
   
    if @post.save
      
      flash[:success] = "Post saved!"

      respond_to do |format|

        format.html {redirect_to new_user_post_path(params[:user_id])}

        format.js {render :create_post}
      end  
    else
      respond_to do |format|
        flash[:alert] = "Post not saved!"
        redirect_to new_user_post_path(params[:user_id])
      end
    end  
  end  

  def show

  end 

  def destroy
    if @post.destroy
      flash[:success] = "Post deleted!"
      
      respond_to do |format|

        format.html {redirect_to new_user_post_path(params[:user_id])}

        format.js {render :delete_post}
      end  
    else
      flash[:alert] = "Post not deleted!"
      redirect_to new_user_post_path(params[:user_id])
    end
  end

  private

  def set_post_user_profile
    if @user = User.find_by_id(params[:user_id])
        @profile = @user.profile 
    else
      flash[:alert] = "No such person! Redirecting to you page!" 
      redirect_to user_path(current_user)
    end 
  end
    
  def set_post
    if @post = Post.find_by_id(params[:id])
       @user = @post.user
       @profile = @user.profile
       @like = @post.likes.where("user_id = ?",current_user.id)
    else
      flash[:alert] = "No such post found! Redirecting to your Timeline!" 
      redirect_to new_user_post_path(current_user)
    end 
  end

  def post_params

    params.require(:post).permit(
      :id,
      :user_id,
      :body
    )
  end

end