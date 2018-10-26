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
      redirect_back(fallback_location: user_timeline_path(User.find(params[:comment][:user_id].to_i)))
    else
      flash[:danger] = "Unable to save your comment"
      redirect_back(fallback_location: user_timeline_path(User.find(params[:comment][:user_id].to_i)))
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user != current_user
      flash[:danger] = "You can NOT delete other user's comments"
      redirect_back(fallback_location: user_timeline_path(current_user))
    else
      if @comment.delete
        flash[:success] = "Comment has been successfully deleted"
        redirect_back(fallback_location: user_timeline_path(current_user))
      else
        flash[:danger] = "Unable to delete comment"
        redirect_back(fallback_location: user_timeline_path(current_user))
      end
    end
  end

private

  def set_resource
    if params[:commentable_type] == 'Post'
      @resource = Post.find(params[:commentable_id].to_i)
    elsif params[:commentable_type] == 'Photo'
      @resource = Photo.find(params[:commentable_id].to_i)
    end
  end

  def whitelisted_comment_params
    params.require(:comment).permit(:body, :user_id, :commentable_id, :commentable_type)
  end

end
