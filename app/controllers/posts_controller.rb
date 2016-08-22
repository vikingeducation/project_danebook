class PostsController < ApplicationController

  def create
    current_user.posts.build(post_params)
    if current_user.save
      flash[:success] = "Created New Post"
    else
      flash[:error] = "Could Not Create Post"
    end
    redirect_to current_user
  end

  def destroy
    post = current_user.posts.find(params[:id])
    post.delete ? flash[:success] = "Deleted Post" : flash[:alert] = "Did Not Delete Post"
    redirect_to current_user
  end


private

  def post_params
    params.require(:post).permit(:body)
  end

end
