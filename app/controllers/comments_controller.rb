class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:success] = "Comment successfully posted"
    else
      flash[:error] = @comment.errors.full_messages.first
    end
    redirect_to timeline_path
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:success] = "Comment deleted!"
    else
      flash[:error] = "Something went wrong! Please try again."
    end
    redirect_to timeline_path
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :author_id, :commentable_type, :commentable_id)
  end

  def extract_commentable
    resource, id = request.path.split('/')[1,2]
    resource.singularize.classify.constantize.find(id)
  end


end
