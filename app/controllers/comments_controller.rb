class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.build(commentable_id: params[:id], commentable_type: params[:type], body:comment_params[:body])
    if @comment.save
      flash[:success] = "Comment Posted!"
      redirect_back(fallback_location: root_path)

    else
      flash[:danger] = "Comment was too short" 

      redirect_back(fallback_location: root_path)
    end
    
  end

  def destroy
    @comment = current_user.comments.where(commentable_id: params[:id], commentable_type: params[:type])
    unless @comment.empty?

      @comment.first.destroy
      flash[:success] = "Comment destroyed"
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "Unauthorized action"
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end



