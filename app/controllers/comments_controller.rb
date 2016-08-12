class CommentsController < ApplicationController

  def destroy
    if signed_in_user?
      @comment = Comment.find(params[:id])
      if @comment.destroy
        flash[:success] = "Unliked the post"
      else
        flash[:error] = "Couldn't make the unlike"
      end
      redirect_to root_path
    else
      redirect_to login_path
    end
  end
end
