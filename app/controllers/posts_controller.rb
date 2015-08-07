class PostsController < ApplicationController
  def create
    post = current_user.profile.posts.build(:body => params[:post][:body])
    post.user_id = current_user.id
    if post.save
      flash[:success] = "New Post"
    else
      flash[:error] = "Could not save. Try again"
    end
      redirect_to profile_timeline_path(current_user.profile)
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

