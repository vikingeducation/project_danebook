class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @user = current_user

    @comment = @post.comments.build(whitelisted_params)
    @type = params[:commentable]

    @comment.update_attributes(user_id: @user.id,
                           commentable_id: @post.id,
                         commentable_type: @type)
    @comment.save
    redirect_to :back
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to :back
  end

  private

  def whitelisted_params
    params.require(:comment).permit(:body)
  end
end
