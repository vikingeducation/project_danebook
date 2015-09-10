class CommentsController < ApplicationController
  before_filter :store_referer
  before_filter :require_author, only: [:destroy]
  def create
    @comment = Comment.new(whitelisted_comment_params)

    respond_to do |format|
      if current_user && current_user == @comment.author
        if @comment.save
          flash[:success] = "Comment successfully saved!"
          format.js {}
        else
          flash[:notice] = "Comment coudln't be saved!"
        end
      else
        flash[:notice] = "You cannot comment as someone else!"
      end
      format.html { redirect_to referer }
    end
  end

  def destroy
    @target_id = @comment.id
    respond_to do |format|
      if @comment.destroy
        flash[:success] = "Comment successfully deleted!"
        format.js {}
      else
        flash[:notice] = "Comment coudln't be deleted!"
      end
      format.html { redirect_to referer }
    end
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
