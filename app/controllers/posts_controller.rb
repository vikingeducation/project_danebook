class PostsController < ApplicationController
  skip_before_action :correct_user

  def create
    @user = current_user
    @posts = @user.posts
    @post = @posts.create!(post_params)
    redirect_to @user.timeline
  end

  private
    def post_params
      params.require(:post).permit(:body, :user_id)
    end
end
