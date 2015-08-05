class CommentsController < ApplicationController

  before_action :require_login, :except => [:index, :show]
  # before_action :require_current_user, :only => [:create, :destroy]

  def create
    session[:return_to] ||= request.referer
    comment = Comment.new(params_list)
    comment.user_id = current_user.id
    if comment.save
      flash[:success] = "You have commented!"
    else
      flash[:error] = "There was an error, please try again!"
    end
    redirect_to session.delete(:return_to)
  end

  def destroy
    session[:return_to] ||= request.referer
    comment = Comment.find(params[:id])
    # fail
    if (current_user.id == comment.user_id) && comment.destroy
      flash[:success] = "Your comment was deleted!"
    else
      flash[:error] = "The comment was not deleted."
    end
    redirect_to session.delete(:return_to)
  end

  def params_list
      params.require(:comment).permit(:body, :id, :user_id,
                        :commentable_type, :commentable_id )
  end
end
