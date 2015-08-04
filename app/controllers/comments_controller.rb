class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:success] = "Comment successfully posted"
      redirect_to timeline_path
    else
      flash.now[:error] = @comment.errors.full_messages
      render 'timelines/show'
    end
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
