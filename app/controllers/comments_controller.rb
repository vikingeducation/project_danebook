class CommentsController < ApplicationController

  def create
    session[:return_to] = request.referer
    commentable = extract_commentable.find(params[:commentable_id])
    comment = commentable.comments.build(comment_params)
    comment.user_id = current_user.id
    unless comment.save
      flash[:alert] = "Could Not Create Comment"
    end
    redirect_to session.delete(:return_to)
  end

  def destroy
    session[:return_to] = request.referer
    commentable = extract_commentable.find(params[:commentable_id])

    if params[:user_id] != current_user.id.to_s
      flash[:error] = "You're not authorized to delete this"
      redirect_to root_url
    end
    if commentable.comments.destroy(params[:id])
      flash[:success] = "deleted comment"
      redirect_to session.delete(:return_to)
    else
      flash[:alert] = "something went wrong"
      redirect_to session.delete(:return_to)
    end
  end


private

  def comment_params
    params.require(:comment).permit(:body)
  end
  def extract_commentable
    params[:commentable_type].singularize.classify.constantize
  end


end
