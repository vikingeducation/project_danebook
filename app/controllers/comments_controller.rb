class CommentsController < ApplicationController

  before_action :require_login

  def create
    @comment = current_user.comments.build(comment_params)
    respond_to do |format|
      if @comment.save
        flash[:success] = "Comment successfully posted"
        format.js
      else
        flash[:error] = @comment.errors.full_messages.first
        format.js { render "shared/flash" }
      end
      format.html { redirect_to ref }
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    respond_to do |format|
      if @comment.author == current_user
        @comment.destroy
        flash[:alert] = "Comment deleted!"
        format.js
      else
        flash[:error] = "You're not allowed to delete other user's comments"
        format.js { render "shared/flash" }
      end
      format.html { redirect_to ref }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :commentable_type, :commentable_id)
  end

end
