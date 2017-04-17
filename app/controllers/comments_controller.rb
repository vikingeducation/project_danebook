class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(comment_params.merge({post_id: params[:post_id]}))
    if @comment.save
      flash[:success] = "Comment posted!"
    else
      flash[:error] = "We couldn't post that comment"
    end
    redirect_to user_profile_path(@post.user)
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
