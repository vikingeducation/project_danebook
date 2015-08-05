class CommentsController < ApplicationController
  before_filter :store_referer

  def create
    @comment = Comment.new(whitelisted_comment_params)
    if @comment.save
      flash[:success] = "Comment saved."
    else
      flash[:notice] = "Comment wasn't saved."
    end
    redirect_to referer
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to referer
  end

  private
    def whitelisted_comment_params
      params.require(:comment).permit(:user_id, :commenting_id, :commenting_type, :body)
    end
end
