class CommentsController < ApplicationController

  before_action :require_login, only: [:create]
  before_action :require_current_user, only: [:destroy]

  def create
    @comment = current_user.comments.build(whitelisted_params)
    if @comment.save
      Comment.delay.send_new_comment_email(@comment.id)
      flash[:success] = "Comment created."

      respond_to do |format|
        format.html
        format.js { render :create_success }
      end
    else
      flash[:error] = "Comment could not be saved"

      respond_to do |format|
        format.html
        format.js
      end
    end
  end


  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:success] = "Comment deleted"

      respond_to do |format|
        format.html
        format.js
      end
    else
      flash[:error] = "Comment could not be deleted"
    end
  end






  private
  def whitelisted_params
    params.require(:comment).permit(:body, :user_id, :commentable_id, :commentable_type)
  end



end
