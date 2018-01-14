class PostsController < ApplicationController
  before_action :require_current_user => [:create, :destroy]

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.order(created_at: :desc)
    @post = current_user.posts.build
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    session[:return_to] = request.referer
    if @post.save
      # redirect_to user_posts_path(@post.user)
      redirect_to session.delete(:return_to)
      flash[:success] = "Created new post!"
    else
      flash.now[:error] = "Failed to Create Post!"
      redirect_to session.delete(:return_to)
      # redirect_to user_posts_path(current_user)
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    session[:return_to] = request.referer
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:success] = "Post deleted successfully."
      redirect_to user_posts_path(@post.user)
    else
      flash[:error] = "Post not deleted"
      redirect_to user_posts_path(@post.user)
    end
  end

  def newsfeed
    @user = current_user
    @post = current_user.posts.build
    @posts = Post.newsfeed(current_user)
  end

  private
  def post_params
     params.require(:post).permit(:body, :user_id)
  end

  def is_authorized?
    if current_user.id.to_s != params[:user_id]
      session[:return_to] ||= request.referer
      redirect_to session.delete(:return_to), :flash => { error: 'You are not authorized to do this action.' }
    else
      true
    end
  end
end
