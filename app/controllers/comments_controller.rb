class CommentsController < ApplicationController
  before_action :require_login

  def create
    if signed_in_user?
      type = params[:comment][:commentable_type].classify
      resource = type.constantize.find(params[:comment][:commentable_id])
      if resource.comments.create(description: params[:comment][:description],user_id: current_user.id)
        flash[:success] = "Comment has been added!"
      else
        flash[:error] = "Comment not added, returning to the nerdery to diagnose the problem. . . ."
      end
      redirect_to :back
    else
      redirect_to login_path
    end
  end

  def destroy
    if signed_in_user?
      @comment = Comment.find(params[:id])
      if @comment.destroy
        flash[:success] = "Comment has been destroyed..."
        redirect_to root_path
      else
        flash[:error] = "Couldn't destroy the comment, it has gone sentient..."
        redirect_to :back
      end
    else
      redirect_to login_path
    end
  end

  private

    def white_listed_comment_params
      params.require(:comment).permit(:description)
    end

end
