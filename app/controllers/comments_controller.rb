class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      @user = @comment.commentable.user
      Comment.delay(run_at: 5.seconds.from_now).send_notification(@user.id, @comment.id)
      flash.notice = "Comment created."
      redirect_back(fallback_location: current_user)
    else
      flash.notice = "Error. Comment not created."
      redirect_back(fallback_location: current_user)
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
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
    params.require(:comment).permit(:body, :commentable_id, :commentable_type)
  end

end
