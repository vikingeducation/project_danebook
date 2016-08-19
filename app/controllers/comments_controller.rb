class CommentsController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    @user.comments.build(comment_params)
    if @user.save
      flash.notice = "Comment created."
      redirect_back(fallback_location: current_user)
    else
      flash.notice = "Error. Comment not created."
      redirect_back(fallback_location: current_user)
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @comment = @user.comments.find(params[:id])
    if @comment.destroy
      flash.notice = "Comment deleted."
      redirect_back(fallback_location: current_user)
    else
      flash.notice = "Error. Comment not deleted."
      redirect_back(fallback_location: current_user)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :post_id)
  end

end
