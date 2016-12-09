class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.build(commentable_id: params[:id], commentable_type: params[:type], body:comment_params[:body])
    if @comment.save
      flash[:success] = "Comment Posted!"
      redirect_to(:back)

    else
      flash[:success] = "Critical Error!"
      raise "error"
      redirect_to(:back)
    end
    
  end

  def destroy
    @comment = current_user.comments.where(commentable_id: params[:id], commentable_type: params[:type])
    @comment.first.destroy
    redirect_to(:back)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end



