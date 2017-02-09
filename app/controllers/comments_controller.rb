class CommentsController < ApplicationController
  include ApplicationHelper

  def create
    @comment = current_user.comments.build(comment_params)
    user = @comment.commentable.user
    if @comment.save
      flash[:success] = "Comment added!"
      redirect_to user_timeline_path(user)
    else
      flash[:warning] = @comment.errors.full_messages
      redirect_to user_timeline_path(user)
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    if @comment.destroy
      flash[:success] = "Deleted!"
    else
      flash[:warning] = "Couldn't delete!"
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :commentable_id, :commentable_type)
  end

end
