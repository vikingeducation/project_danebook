class CommentsController < ApplicationController

  def create
    @comment = Comment.new(whitelisted_comments_params)
    if @comment.save
      flash[:success] = "Successfully commented on the post"
    else
      flash[:danger] = "Unable to comment on the post"
    end
    redirect_to timeline_user_path(current_user)
  end

  def destroy
    if Comment.find(params[:id]).destroy!
      flash[:success] = "Successfully deleted the comment"
    else
      flash[:danger] = "Unable to delete on the post"
    end
    redirect_to timeline_user_path(current_user)
  end

  private
  def whitelisted_comments_params
    params.require(:comment).permit(:text, :user_id, :post_id)
  end

end
