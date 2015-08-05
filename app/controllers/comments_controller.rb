class CommentsController < ApplicationController

  def create
    session[:return_to] ||= request.referer
    @comment = Comment.new(params_list)
    @comment.user_id = current_user.id
    if @comment.save
      # fail
      flash[:success] = "You have commented!"
    else
      flash[:error] = "There was an error, please try again!"
    end
    redirect_to session.delete(:return_to)
  end

  def params_list
      params.require(:comment).permit(:body, :id, :user_id,
                        :commentable_type, :commentable_id )
  end
end
