class PostsController < ApplicationController
  
  def index
    @posts = Post.all
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
end
