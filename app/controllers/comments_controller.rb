class CommentsController < ApplicationController
  include ApplicationHelper

  def create
    @comment = current_user.comments.build(comment_params)
    @user = post_author(@comment.post.id)
    if @comment.save
      flash[:success] = "Comment added!"
      redirect_to user_timeline_path(@user)
    else
      flash[:warning] = @comment.errors.full_messages
      redirect_to user_timeline_path(@user)
    end
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end

end
