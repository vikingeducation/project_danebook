class CommentsController < ApplicationController
  before_action :require_current_user

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

  def require_current_user
    session[:return_to] ||= request.referer
    unless params[:comment][:user_id] == current_user.id
      flash[:warning] = "You are not authorized to do this!"
      redirect_to session.delete(:return_to)
    end
  end
end
