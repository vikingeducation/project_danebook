class CommentsController < ApplicationController

  def new
    @comment = Comment.new
    redirect_to user_posts_path(params[:user_id])
  end

  def create
    # post = Post.find(params[:post_id])

    comment = Comment.new(whitelisted_comment_params)
    if comment.save
      flash[:success] = "Successfully created comment"
    else
      flash[:error] = "Failed to create comment"
    end
    redirect_to user_posts_path(params[:comment][:user_id])
  end

  private

    def whitelisted_comment_params
      params.require(:comment).permit(:body, :user_id, :commentable_id, :commentable_type)
    end
end
