class PostsController < ApplicationController
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Status updated"
      redirect_to @post.user
    else
      flash.now[:error] = "Something went wrong with your post"
      render user_path(@post.user)
    end
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
