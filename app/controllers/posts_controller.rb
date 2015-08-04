class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.written_posts
    @new_post = Post.new(author: @user)
  end

  def create
    @post = Post.new(whitelist_post_params)
    if @post.save
      flash[:success] = "Successfully posted to your timeline!"
      redirect_to user_posts_path
    else
      flash[:notice] = "Couldn't post to your timeline..."
      redirect_to user_posts_path
    end
  end

  private

    def whitelist_post_params
      params.require(:post).permit(:user_id, :body)
    end
end
