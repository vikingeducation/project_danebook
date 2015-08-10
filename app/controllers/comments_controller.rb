class CommentsController < ApplicationController

  before_action :require_login
  before_action :require_current_user, :only => [:create, :destroy]

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      flash[:success] = "Comment successfully posted"
    else
      flash[:error] = @comment.errors.full_messages.first
    end
    redirect_to URI(request.referer).path
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:success] = "Comment deleted!"
    else
      flash[:error] = "Something went wrong! Please try again."
    end
    redirect_to URI(request.referer).path
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :commentable_type, :commentable_id)
  end

end
