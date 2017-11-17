class PostsController < ApplicationController
  before_action :require_current_user => [:create, :destroy]

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.order(created_at: :desc)
    # @posts = Post.all
    binding.pry
    @post = @user.posts.build if is_authorized?
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to :show
      flash[:success] = "Created new post!"
    else
      current_user.build_post
      flash.now[:error] = "Failed to Create Post!"
      redirect_to :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def post_params
     params.require(:post).permit(:body, :user_id)
  end

  def timeline
     @posts = Post.all
  end

  private
  def is_authorized?
    binding.pry
    if current_user.id.to_s != params[:user_id]
      redirect_to root_url, :flash => { error: 'You are not authorized to do this action.' }
    end
  end
end
