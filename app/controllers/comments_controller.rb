class CommentsController < ApplicationController

  before_action :require_login

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      flash[:success] = "Comment successfully posted"
    else
      flash[:error] = @comment.errors.full_messages.first
    end
    redirect_to ref
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.author == current_user
      @comment.destroy
      flash[:alert] = "Comment deleted!"
    else
      flash[:error] = "You're not allowed to delete other user's comments"
    end
    redirect_to ref
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :commentable_type, :commentable_id)
  end

end
