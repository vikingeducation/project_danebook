class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    creation_params = whitelisted_comment_params.to_h.merge({user_id: current_user.id})
    if @post.comments.create!(creation_params)
      flash[:success] = 'Comment created!'
      redirect_to :back
    else
      flash[:error] = 'Unable to comment :('
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

  def whitelisted_comment_params
    params.require(:comment).permit(:id, :comment_text)
  end
end
