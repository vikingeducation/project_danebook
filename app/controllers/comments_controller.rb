class CommentsController < ApplicationController


  def create
    @comment = current_user.comments_written.new(body: comment_params[:body], commentable_id: params[:post_id], commentable_type: "Post")
    if @comment.save!
      flash[:success] = "Your comment has been posted"
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "Your comment could not be posted"
      redirect_back(fallback_location: root_path)
    end
  end


  def destroy
    @comment = Comment.find(params[:id])
    if current_user.id == @comment.user_id && @comment.destroy!
      flash[:success] = "Your comment has been deleted"
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "Your comment could not be deleted"
      redirect_back(fallback_location: root_path)
    end

  end


  private

  def comment_params
    params.require(:comment).permit(:body, :post_id)
  end


end
