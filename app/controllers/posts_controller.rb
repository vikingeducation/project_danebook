class PostsController < ApplicationController
  before_action :require_current_user => [:create, :destroy]

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.order(created_at: :desc)
    @post = @user.posts.build if is_authorized?
    # binding.pry
    
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to user_posts_path(@post.user)
      flash[:success] = "Created new post!"
    else
      @post.user.build_post
      flash.now[:error] = "Failed to Create Post!"
      redirect_to user_posts_path(@post.user)
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def post_params
     params.require(:post).permit(:body, :user_id)
  end

  def destroy
    session[:return_to] ||= request.referer
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:success] = "Post deleted successfully."
      redirect_to user_posts_path(@post.user)
    else
      flash[:error] = "Post not deleted"
      current_user.build_post
      redirect_to session.delete(:return_to)
    end
  end

  private
  def is_authorized?
    if current_user.id.to_s != params[:user_id]
      redirect_to root_url, :flash => { error: 'You are not authorized to do this action.' }
    else
      true
    end
  end
end
