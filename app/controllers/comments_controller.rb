class CommentsController < ApplicationController

  before_action :require_login, only: [:create]
  before_action :require_current_user, only: [:destroy]

  def create
    @comment = current_user.comments.build(whitelisted_params)
    if @comment.save
      Comment.delay.send_new_comment_email(@comment.id)
      flash[:success] = "Comment created."
    else
      flash[:error] = "Comment could not be saved"
    end
    redirect_to :back
  end


  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:success] = "Comment deleted"
    else
      flash[:error] = "Comment could not be deleted"
    end
    redirect_to :back
  end






  private
  def whitelisted_params
    params.require(:comment).permit(:body, :user_id, :commentable_id, :commentable_type)
  end



end
