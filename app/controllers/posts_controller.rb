class PostsController < ApplicationController

  def create
    @post = current_user.posts.build(post_params)
    unless @post.save
      flash[:danger] = "Please enter something!"
    end
  
    redirect_to current_user
  end

  def destroy
    begin
      if (@post = current_user.posts.find(params[:id])) && @post.destroy
        flash[:success] = "Post deleted!"
      else
        flash[:danger] = "Post could not be deleted!"
      end
    rescue ActiveRecord::RecordNotFound
      flash[:danger] = "Post could not be deleted!"
    end
    redirect_to current_user
  end

  private

  def post_params
    params.
      require(:post).
      permit(:text)
  end
end
