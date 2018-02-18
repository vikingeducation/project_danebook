class CommentsController < ApplicationController

  before_action :require_comment_creator, :only => [:destroy]

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      commented_user = User.find(@comment.commentable.user_id)
      commented_user.send_comment_udpates_email(@comment) if commented_user.id != @comment.user_id
      flash[:success] = "You have created new comment"
      redirect_back(fallback_location: root_path)
      # user_timeline_path(@comment.user_id)
    else
      flash[:danger] = "Something went wrong! No post created!"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    if @comment.destroy
      flash[:success] = "You have deleted comment successfully!"
      redirect_back(fallback_location: root_path)
    else
      flash.now[:danger] = "Deleting comment didn't work :("
      redirect_back(fallback_location: root_path)
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
