class PostsController < ApplicationController

#  before_filter :store_referer, :only => [:create, :destroy]
  before_action :require_login

  def create
    @post = current_user.posts.build(post_params)
    respond_to do |format|
      if @post.save
        flash[:success] = "Post successfully submitted"
        format.js
      else
        flash[:error] = @post.errors.full_messages.first
        format.js { render "shared/flash" }
      end
      format.html { redirect_to ref }
    end
  end

  def destroy
    @post = Post.find(params[:id])
    respond_to do |format|
      if @post.author == current_user
        @post.destroy
        flash[:alert] = "Your post was deleted!"
        format.js
      else
        flash[:error] = "You're not authorized to delete this post!"
        format.js { render "shared/flash" }
      end
      format.html { redirect_to ref }
    end
  end


  private

  def post_params
    params.require(:post).permit(:body, :recipient_user_id)
  end

end
