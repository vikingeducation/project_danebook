class CommentsController < ApplicationController
  skip_before_action :correct_user

  def update
    @comment = Comment.find(params[:id])
    @user = @comment.user
    if @comment.update(comment_params)
      flash[:success] = "You've liked this comment!"
      queue_like_email(@user,@comment)
      redirect_to @user.timeline
    else
      flash[:danger] = "Comment could not be liked.."
      redirect_to @user.timeline
    end
  end

  def destroy
  end

  private

  private
    def comment_params
      params.require(:comment).permit(:body, 
                                   :user_id,
                                   { likes_attributes: [:user_id,:_destroy] })
    end
end
