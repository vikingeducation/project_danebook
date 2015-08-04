class PostsController < ApplicationController

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "Post successfully submitted"
      redirect_to timeline_path
    else
      flash.now[:error] = @post.errors.full_messages
      render 'timelines/show'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:alert] = "Your post was deleted!"
    redirect_to timeline_path
  end


  private

  def post_params
    params.require(:post).permit(:body, :user_id)
  end

end
