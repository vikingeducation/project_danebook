class PostsController < ApplicationController

  def create
    new_post = Post.new(whitelisted_post_params)
    if new_post.save
      flash[:success] = "Created new post!"
      redirect_to timeline_user_path(new_post.user)
    else
      @user = current_user
      @profile = @user.profile
      @post = new_post
      render 'users/timeline'
    end
  end

  def update

  end

  def destroy

  end

  private

  def whitelisted_post_params
    params.require(:post).permit(:text, :user_id)
  end
end
