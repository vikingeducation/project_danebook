class CommentsController < ApplicationController

  def create
    @commentable = get_commentable_resource
    creation_params = whitelisted_comment_params.to_h.merge({user_id: current_user.id})
    @comment = @commentable.comments.build(creation_params)
    if @comment.save
      flash[:success] = 'Comment created!'
      redirect_to :back
    else
      flash[:error] = 'Unable to post comment :('
      redirect_to :back
    end
  end

  def destroy
    if Comment.find(params[:id]).destroy
      flash[:success] = 'Comment deleted'
      redirect_to :back
    else
      flash[:error] = 'Unable to delete comment'
      redirect_to :back
    end
  end


  private

  def get_commentable_resource
    resource = Post.find(params[:post_id]) if params[:post_id]
    resource = Comment.find(params[:comment_id]) if params[:comment_id]
    resource = Photo.find(params[:photo_id]) if params[:photo_id]
    resource
  end

  def whitelisted_comment_params
    params.require(:comment).permit(:id, :comment_text)
  end
end
