class PostsController < ApplicationController

#  before_filter :store_referer, :only => [:create, :destroy]
  before_action :require_login

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post successfully submitted"
    else
      flash[:error] = @post.errors.full_messages.first
    end
    redirect_to ref
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.author == current_user
      @post.destroy
      flash[:alert] = "Your post was deleted!"
    else
      flash[:error] = "You're not authorized to delete this post!"
    end
    redirect_to ref
  end


  private

  def post_params
    params.require(:post).permit(:body, :recipient_user_id)
  end

end
