class PostsController < ApplicationController

  def create
    @user = current_user
    @user.posts.build(body: params[:body])

    if @current_user.save
      flash[:success] = "You created a post"
      redirect_to timeline_path
    else
      flash.now[:error] = "Failed to create post"
      render :timeline
    end
  end

  def destroy

  end


end
