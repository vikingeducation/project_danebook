class CommentsController < ApplicationController
  before_filter :store_referer
  def create
    @comment = Comment.new(whitelisted_comment_params)
    if @comment.save
      flash[:success] = "Comment successfully saved!"
    else
      flash[:notice] = "Comment coudln't be saved!"
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
      params.require(:comment).permit(:user_id, :commentable_id, :commentable_type, :body)
    end

end
