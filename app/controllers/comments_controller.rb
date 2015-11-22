class CommentsController < ApplicationController
  before_action :require_current_user, :only => [:create, :destroy]
  before_action :require_current_user_is_comment_user, :only => [:destroy]

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      flash[:success] = 'Comment created'
    else
      flash[:error] = 'Comment not created: ' +
        @comment.errors.full_messages.join(', ')
    end
    redirect_to request.referer
  end

  def destroy
    if @comment.destroy
      flash[:success] = 'Comment destroyed'
    else
      flash[:error] = 'Comment not destroyed: ' +
        @comment.errors.full_messages.join(', ')
    end
    redirect_to request.referer
  end


  private
  def comment_params
    params.require(:comment)
      .permit(
        :body,
        :commentable_id,
        :commentable_type
      )
  end

  def require_current_user_is_comment_user
    @comment = current_user.comments.find(params[:id])
    unless @comment
      flash[:error] = 'You are unauthorized to perform that action'
      redirect_to root_path
    end
  end
end
