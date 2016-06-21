class CommentsController < ApplicationController
  before_action, :require_login

  def create
    @comment = current_user.comments.build(whitelisted_params)
    @comment.post_id = params[:post_id]
    if @comment.save
      flash[:success] = "You just commented on that post"
    end
    redirect_to (:back)
  end

  private

  def whitelisted_params
    params.require(:comment).permit(:body, :user_id, :post_id)
  end
end
