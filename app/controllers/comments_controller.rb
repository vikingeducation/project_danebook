class CommentsController < ApplicationController
  before_action :require_current_user, only: [:create]

  def create
    session[:return_to] = request.referer
    @comment = Comment.new(whitelisted_comment_params)
    if @comment.save
      flash[:success] = "You have commented on this post."
      respond_to do |format|
        format.html { redirect_to session.delete(:return_to) }
        format.js { render :create_success }
      end
    else
      flash[:error] = "Error!"
      respond_to do |format|
        format.html { redirect_to session.delete(:return_to) }
      end
    end
  end

  def destroy
    session[:return_to] = request.referer
    @comment = Comment.find(params[:id])
    if @comment.user == current_user && @comment.destroy
      flash[:success] = "Deleted"
      respond_to do |format|
        format.html { redirect_to session.delete(:return_to) }
        format.js { render :delete_success }
      end
    else
      flash[:error] = "Indestructible"
      respond_to do |format|
        format.html { redirect_to session.delete(:return_to) }
      end
    end
  end

  private

  def whitelisted_comment_params
    params.require(:comment).permit(:user_id,
                                    :body, 
                                    :commentable_id,
                                    :commentable_type)
  end

  def require_current_user
    session[:return_to] = request.referer
    unless params[:comment][:user_id] == current_user.id.to_s
      flash[:warning] = "You are not authorized to do this!"
      redirect_to session.delete(:return_to)
    end
  end
end
