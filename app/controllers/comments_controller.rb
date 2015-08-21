class CommentsController < ApplicationController

  before_action :require_login, :only => [:create]
  before_action :require_current_user, :only => [:destroy]


  def create
    @new_comment = current_user.comments.build(comment_params)
    if @new_comment.save
      flash[:success] = "Comment created!"
    else
      flash[:danger] = "Comment not saved. Please try again."
    end
    redirect_to user_posts_path(@new_comment.commentable.author)
  end


  def destroy
    comment = Comment.find(params[:id])
    author = comment.commentable.author
    if comment.destroy!
      flash[:success] = 'Comment deleted!'
    else
      flash[:danger] = "Sorry, we couldn't delete your comment. Please try again."
    end
    redirect_to user_posts_path(author)
  end


  private


    def comment_params
      params.require(:comment).permit(:body, :commentable_id, :commentable_type)
    end


    def require_current_user
      comment = Comment.find(params[:id])
      unless comment.author == current_user
        flash[:danger] = "You're not authorized to do this!"
        redirect_to user_posts_path(comment.commentable.author)
      end
    end

end
