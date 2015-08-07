
class CommentsController < ApplicationController


  def create
    session[:return_to] ||= request.referer
    comment = Comment.new(comment_params_list)
    comment.author_id = current_user.id
    unless comment.save
      flash[:error] = "An error has occured"
    end
    redirect_to session.delete(:return_to)
  end

  def destroy
    session[:return_to] ||= request.referer
    comment = Comment.find(params[:id])
    if current_user.id == comment.author_id
        comment.destroy
    else
      flash[:error] = "Deletion failed"
    end
    redirect_to session.delete(:return_to)
  end

  private

  def comment_params_list
      params.require(:comment)
      .permit(:body, :id, :user_id, :commentable_type,
              :commentable_id )
  end
end
