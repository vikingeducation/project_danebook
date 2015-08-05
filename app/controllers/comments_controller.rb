class CommentsController < ApplicationController

  def new
    
    @comment = Comment.new
    redirect_to user_posts_path(params[:user_id])
  
  end

  def create

    comment = Comment.new(whitelisted_comment_params)
    if comment.save
      flash[:success] = "Successfully created comment"
    else
      flash[:error] = "Failed to create comment"
    end
    redirect_to user_posts_path(params[:comment][:user_id])
  
  end

  def destroy
    
    comment = Comment.find(params[:id])
    user_id = comment.user_id
    if comment.destroy
      flash[:success] = "Successfully deleted comment"
    else
      flash[:error] = "Failed to delete comment"
    end
    redirect_to user_posts_path(user_id)
  
  end

  private

    def whitelisted_comment_params
      params.require(:comment).permit(:body, :user_id, :commentable_id, :commentable_type)
    end
end
