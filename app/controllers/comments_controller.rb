class CommentsController < ApplicationController

  before_action :set_user
  before_action :require_login, only: [:create, :destroy]
  before_action :set_post

  def index
    @comments = @post.comments
    @comment = @post.comments.build
  end

  def new
    @comment = @post.comments.build
  end

  def create
    @comment = @post.comments.build(whitelisted_comment_params)
    if @comment.save
      flash[:success] = "Comment saved!"
      redirect_to user_timeline_path(User.find(Post.find(@post.id).user.id))
    else
      flash[:danger] = "Unable to save your comment"
      redirect_to user_timeline_path(User.find(Post.find(@post.id).user.id))
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user != current_user
      flash[:danger] = "You can NOT delete other user's comments"
      redirect_back(fallback_location: user_timeline_path(current_user))
    else
      if @comment.delete
        flash[:success] = "Comment has been successfully deleted"
        redirect_back(fallback_location: user_timeline_path(current_user))
      else
        flash[:danger] = "Unable to delete comment"
        redirect_back(fallback_location: user_timeline_path(current_user))
      end
    end
  end

private

  def set_post
    @post = Post.find(params[:post_id].to_i)
  end

  def whitelisted_comment_params
    params.require(:comment).permit(:body, :user_id, :post_id)
  end

end
