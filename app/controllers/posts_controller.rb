class PostsController < ApplicationController

  def index
    @posts = Post.all_friend_posts(current_user)
    @post = Post.new
  end

  def create
    @post = current_user.authored_posts.build(post_params)
    if @post.save
      flash[:success] = "Nice post chum!"
      redirect_to current_user
    else
      flash[:error] = "Oops! Something went wrong. Our apes are researching this problem as we speak."
      redirect_to current_user
    end
  end

  def destroy
    @post = Post.find_by_id(params[:id])
    if @post.destroy
      flash[:success] = "We nuked it dawg! It is gone!"
      redirect_to current_user
    else
      flash[:error] = "Oops! Something went wrong. Our apes are researching this problem as we speak."
      redirect_to current_user
    end
  end

  private

  def post_params
    params.require(:post).permit(:body, :id, :author_id)
  end

end
