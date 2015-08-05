class PostsController < ApplicationController
  def create
    post = current_user.posts.build(:body => params[:post][:body])
    if post.save
      flash[:success] = "New Post"
    else
      flash[:error] = "Could not save. Try again"
    end
      redirect_to user_timeline_path(current_user)
  end

  def destroy
    if current_user && current_user.id == params[:user_id]
      Post.destroy(params[:id])
    else
      flash[:error] = "You can only delete you own posts"
    end
    redirect_to user_timeline_path(current_user)
  end
end

