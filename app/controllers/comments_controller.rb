class CommentsController < ApplicationController
  before_action :require_login

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(strong_comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:success] = "Comment published!"
      redirect_back(fallback_location: user_posts_path(@comment.user))
    else
      flash[:warning] = "Comment could not be published."
      redirect_back(fallback_location: user_posts_path(@comment.user))
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    comment_user = @comment.user
    if comment_user == current_user
      if @comment.destroy
        flash[:success] = "Comment deleted."
        redirect_back(fallback_location: user_posts_path(comment_user))
      else
        flash[:warning] = "Comment could not be deleted."
        redirect_back(fallback_location: user_posts_path(comment_user))
      end
    else
      flash[:warning] = "You can only delete your own comments."
      redirect_back(fallback_location: user_posts_path(comment_user))
    end
  end

  private
    def strong_comment_params
      # p params
      params.require(:comment).permit(:body, :user_id, :post_id)
    end
end
