class CommentsController < ApplicationController

  before_action :set_return_path, only: [:create, :destroy]

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      flash[:success] = "Comment added."
    else
      flash[:error] = "Comment not added."
    end
    redirect_to session.delete(:return_to)
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    if @comment.destroy
      flash[:success] = "Comment deleted."
    else
      flash[:error] = "Something went wrong."
    end
    redirect_to session.delete(:return_to)
  end

  private

    def comment_params
      params.require(:comment).permit(:body, :commentable_type, :commentable_id)
    end

end
