class PostsController < ApplicationController
  before_action :require_login, only: [:create, :destroy]
  before_action :require_current_user, only: [:create]
  before_action :require_current_author, only: [:destroy]

  def create
    @user = User.find(params[:user_id])
    current_user.posts.build(body: params[:post_body])

    if current_user.save
      flash[:success] = "You created a post"
      redirect_to user_timeline_path(@user)
    else
      flash.now[:error] = "Failed to create post"
      render :timeline
    end
  end

  def destroy
    post = Post.find(params[:id])
    current_user.posts.destroy(post)
    flash[:success] = "You successfully destroyed post"
    redirect_to user_timeline_path(@current_user)
  end

  private

    def require_current_author
      post = Post.find(params[:id])
      unless post.author == current_user
        flash[:error] = "You are not authorized to delete this post"
        redirect_to current_user
      end
    end
end
