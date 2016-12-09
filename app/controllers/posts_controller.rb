class PostsController < ApplicationController
  def index
    @post = Post.new
    @posts = Post.last(30).reverse
  end
 
  def create
    @post =  current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Posted!"
      redirect_to(:back)
    else
      flash.now[:danger] = "Post failed! Did you remeber to include text?"
      render :index
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to(:back)
  end

  def post_params
    params.require(:post).permit(:body)
  end


end
