class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comments_params)
    session[:return_to] ||= request.referer
    if @comment.save

      if @comment.user_id != current_user.id
        User.send_notification_email(@user.id)
      end


      redirect_to session.delete(:return_to)
      flash[:success] = "Commented on the item!"
    else
      flash.now[:error] = "Failed to comment on the item"
      redirect_to session.delete(:return_to)
    end
  end

  def destroy
    session[:return_to] ||= request.referer

    @comment = Comment.find(params[:id])

    if @comment.destroy
      flash[:success] = "Destroyed the comment"
      redirect_to session.delete(:return_to)
    else
      flash[:error] = "Didn't destroy the comment"
      redirect_to session.delete(:return_to)
    end
  end

  def comments_params
    params.require(:comment).permit(:user_id, :body, :commentable_id, :commentable_type)
  end
end
