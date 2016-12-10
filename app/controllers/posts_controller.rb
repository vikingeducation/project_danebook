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
      flash[:danger] = "Post failed! Did you remeber to include text?"
      redirect_to :back
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user_id = current_user.id
      @post.destroy
      redirect_to(:back)
    else
      flash[:danger] = "Bad bad bad!"
      redirect_to(:back)
    end
  end

  def post_params
    params.require(:post).permit(:body)
  end


end
