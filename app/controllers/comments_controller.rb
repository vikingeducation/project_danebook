class CommentsController < ApplicationController
  before_action :require_login
  before_action :require_current_user, :only => [:destroy]

  def create
    
    @comment = Comment.new(comment_params)
    
    if @comment.save
      flash[:success] = "Comment saved!"
      redirect_user_path(params["comment"][:user_id])
    else
      flash[:alert] = "Comment not saved!"
      redirect_user_path(params["comment"][:user_id])
    end
  end 

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:success] = "Comment deleted!"
      redirect_to new_user_post_path(params[:user_id])
    else
      flash[:alert] = "Cmment not deleted!"
      redirect_to new_user_post_path(params[:user_id])
    end
 end

  private

  def redirect_user_path(user_id)
    if user_id == current_user.id.to_s
       redirect_to new_user_post_path(user_id)
    else
       redirect_to user_posts_path(user_id)
    end 
  end
    
  def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type, :user_id)
  end
end
