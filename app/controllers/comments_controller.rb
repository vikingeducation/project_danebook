class CommentsController < ApplicationController

  before_action :set_user
  before_action :require_login, only: [:create, :destroy]
  before_action :set_resource

  def index
    @comments = @resource.comments
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(whitelisted_comment_params)
    if @comment.save
      unless @comment.user_id == @comment.commentable_type.constantize.find(@comment.commentable_id).user.id
        Comment.delay.send_comment_notification(@comment.id)
      end
      flash[:success] = "Comment saved!"
    else
      flash[:danger] = "Unable to save your comment"
    end
    redirect_back(fallback_location: user_timeline_path(User.find(params[:comment][:user_id].to_i)))
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user != current_user
      flash[:danger] = "You can NOT delete other user's comments"
    else
      if @comment.delete
        flash[:success] = "Comment has been successfully deleted"
      else
        flash[:danger] = "Unable to delete comment"
      end
    end
    redirect_back(fallback_location: user_timeline_path(current_user))
  end

private

  def set_resource
    @resource = params[:comment][:commentable_type].constantize.find(params[:comment][:commentable_id].to_i)
  end

  def whitelisted_comment_params
    params.require(:comment).permit( :body,
                                     :user_id,
                                     :commentable_id,
                                     :commentable_type
                                   )
  end

end
