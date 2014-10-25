class CommentsController < ApplicationController
  def create
    # so they can go back thence they came
    session[:return_to] ||= request.referer
    @comment = commentable.comments.build(author_id: current_user.id, content: comment_params[:content])
    if @comment.save
      flash[:success] = "Commented"
      redirect_to session.delete(:return_to)
    else
      flash[:error] = "An error occurred while commenting"
      redirect_to session.delete(:return_to)
    end
  end

  def destroy
    session[:return_to] ||= request.referer
    @comment = current_user.comments.find(params[:id])
    if @comment.destroy
      flash[:success] = "Comment deleted"
      redirect_to session.delete(:return_to)
    else
      flash[:error] = "An error occurred while deleting the comment"
      redirect_to session.delete(:return_to)
    end
  end

  private

  def parent_id
    "#{params[:commentable].to_s}_id".downcase.to_sym
  end

  def commentable
    # use the params to find the appropriate model and object
    params[:commentable].capitalize.constantize.find(params[parent_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
