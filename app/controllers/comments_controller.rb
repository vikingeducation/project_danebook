class CommentsController < ApplicationController

  before_action :require_comment_creator, :only => [:destroy]

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      flash[:success] = "You have created new comment"
      redirect_to :back
      # user_timeline_path(@comment.user_id)
    else
      flash[:danger] = "Something went wrong! No post created!"
      redirect_to :back
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    if @comment.destroy
      flash[:success] = "You have deleted comment successfully!"
      redirect_to :back
    else
      flash.now[:danger] = "Deleting comment didn't work :("
      redirect_to :back
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type)
  end

  def require_comment_creator
    unless params[:user_id] == current_user.id.to_s
      flash[:danger] = "Your are not authorized to do this."
      redirect_to root_url
    end
  end

end
