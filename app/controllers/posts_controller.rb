class PostsController < ApplicationController

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post successfully submitted"
    else
      flash[:error] = @post.errors.full_messages.first
    end
    redirect_to timeline_path
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:alert] = "Your post was deleted!"
    redirect_to timeline_path
  end


  private

  def post_params
    params.require(:post).permit(:body)
  end

end
