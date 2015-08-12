class CommentsController < ApplicationController
  skip_before_action :require_current_user

  def create
    session[:return_to] ||= request.referer
    @comment = Comment.new(whitelisted_comment_params)
    if @comment.save
      flash[:success] = "You have commented on this post."
    else
      flash[:error] = "Error!"
    end
    redirect_to session.delete(:return_to)
  end

  def destroy
    session[:return_to] ||= request.referer
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:success] = "Deleted"
    else
      flash[:error] = "Indestructible"
    end
    redirect_to session.delete(:return_to)
  end

  private

  def whitelisted_comment_params
    params.require(:comment).permit(:user_id,
                                    :body, 
                                    :commentable_id,
                                    :commentable_type)
  end 
end
