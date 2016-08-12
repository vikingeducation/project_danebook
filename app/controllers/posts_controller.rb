class PostsController < ApplicationController

  def index
  end

  def create
    if current_user.posts.create(post_params)
      flash[:success] = "Created New Post"
    else
      flash[:alert] = "Could Not Create Post"
    end
    redirect_to current_user
  end

  def destroy
    post = current_user.posts.find(params[:post_id])
    post.delete ? flash[:success] = "Deleted Post" : flash[:alert] = "Did Not Delete Post"
    redirect_to current_user
  end


private

  def post_params
    params.require(:post).permit(:body)
  end

end
