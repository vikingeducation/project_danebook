class PostsController < ApplicationController
  before_action :require_login, only: [:create, :destroy]
  # before_action :require_current_user, only: [:create, :destroy]

  def create
    @user = User.find(params[:id])
    @user.posts.build(body: params[:body])

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
    redirect_to user_timeline_path(@current_user)
  end


end
