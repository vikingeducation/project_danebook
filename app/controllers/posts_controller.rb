class PostsController < ApplicationController
  def index
    @post = Post.new
    @posts = Post.last(30).reverse
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "Posted!"
      redirect_to posts_index_path
    else
      flash.now[:danger] = "Post failed! Did you remeber to include text?"
      render :index
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
     redirect_to posts_index_path
  end

  def post_params
    params.require(:post).permit(:body, :user_id)
  end
end
