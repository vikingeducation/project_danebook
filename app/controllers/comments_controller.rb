class CommentsController < ApplicationController
  before_action :require_current_user, :only => [:edit, :update, :destroy]


  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:success] = "comment created!"
      redirect_to URI(request.referer).path
    else
      flash[:error] = "Unable to create comment"
      redirect_to timeline_path(current_user)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:success] = "comment deleted!"
      redirect_to timeline_path(current_user)
    else
      flash[:error] = "Unable to delete comment!"
      redirect_to timeline_path(current_user)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :body, :created_at, :updated_at, :commentable_id, :commentable_type)
  end
end
