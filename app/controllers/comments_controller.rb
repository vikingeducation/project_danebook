class CommentsController < ApplicationController
  before_action :require_login

  def create
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    comment.save
    redirect_to request.referrer

  end

  def destroy
    comment = Comment.find_by_id(params[:id])
    comment.destroy if comment
    redirect_to request.referrer
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :body)
  end

end
