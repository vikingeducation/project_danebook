class PostsController < ApplicationController

  #before_filter :store_referer, :only => [:create, :destroy]

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post successfully submitted"
    else
      flash[:error] = @post.errors.full_messages.first
    end
    redirect_to URI(request.referer).path
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @post.destroy
    flash[:alert] = "Your post was deleted!"
    redirect_to URI(request.referer).path
  end


  private

  def post_params
    params.require(:post).permit(:body, :recipient_user_id)
  end

end
