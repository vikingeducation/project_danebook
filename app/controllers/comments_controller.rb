class CommentsController < ApplicationController
  before_action :require_login

  def create
    if signed_in_user?
      session[:return_to] = request.referer
      post = Post.find(params[:post_id])
      comment = post.comments.build(white_listed_comment_params)
      comment.user_id = current_user.id
      if comment.save
        flash[:success] = "Comment has been added!"
      else
        flash[:error] = "Comment not added, returning to the nerdery to diagnose the problem. . . ."
      end
      redirect_to session.delete(:return_to)
    else
      redirect_to login_path
    end
  end

  def destroy
    if signed_in_user?
      @comment = Comment.find(params[:id])
      if @comment.destroy
        flash[:success] = "Comment has been destroyed..."
      else
        flash[:error] = "Couldn't destroy the comment, it has gone sentient..."
      end
      redirect_to root_path
    else
      redirect_to login_path
    end
  end

  private

    def white_listed_comment_params
      params.require(:comment).permit(:description)
    end
end
