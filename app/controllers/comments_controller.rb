class CommentsController < ApplicationController

  before_action :set_user
  before_action :require_login, only: [:create, :destroy]

  def index
    @resource = params[:comment][:commentable_type].constantize.find(params[:comment][:commentable_id].to_i)
    @comments = @resource.comments
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(whitelisted_comment_params)
    if @comment.save
      unless @comment.user_id == @comment.commentable_type.constantize.find(@comment.commentable_id).user.id
        Comment.delay.send_comment_notification(@comment.id) unless on_do_not_email_list?(@comment)
      end
      flash[:success] = "Comment saved!"
    else
      flash[:danger] = "Unable to save your comment - #{:body.to_s.titleize} #{@comment.errors[:body].first}"
    end
    redirect_back(fallback_location: user_timeline_path(User.find(params[:comment][:user_id].to_i)))
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user != current_user
      flash[:danger] = "You can NOT delete other user's comments"
    else
      if @comment.destroy
        flash[:success] = "Comment has been successfully deleted"
      else
        flash[:danger] = "Unable to delete comment"
      end
    end
    redirect_back(fallback_location: user_timeline_path(current_user))
  end

private

  def whitelisted_comment_params
    params.require(:comment).permit( :body,
                                     :user_id,
                                     :commentable_id,
                                     :commentable_type
                                   )
  end

  def on_do_not_email_list?(comment)
    User.find(comment.commentable_type.constantize.find(comment.commentable_id).user.id).unsubscribe 
  end

end
