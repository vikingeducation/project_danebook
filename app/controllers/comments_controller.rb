class CommentsController < ApplicationController
  before_filter :store_referer
  before_filter :require_author, only: [:destroy]
  def create
    @comment = Comment.new(whitelisted_comment_params)
    if current_user && current_user == @comment.author
      if @comment.save
        flash[:success] = "Comment successfully saved!"
      else
        flash[:notice] = "Comment coudln't be saved!"
      end
    else
      flash[:notice] = "You cannot comment as someone else!"
    end
    redirect_to referer
  end

  def destroy
    if @comment.destroy
      flash[:success] = "Comment successfully deleted!"
    else
      flash[:notice] = "Comment coudln't be deleted!"
    end
    redirect_to referer
  end

  private

    def require_author
      @comment = Comment.find(params[:id])
      unless current_user == @comment.author
        flash[:notice] = "You cannot delete another user's comment."
        redirect_to referer
      end
    end

    def whitelisted_comment_params
      params.require(:comment).permit(:user_id, :commentable_id, :commentable_type, :body)
    end

end
