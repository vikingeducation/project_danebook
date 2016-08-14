class CommentsController < ApplicationController
  skip_before_action :correct_user

  def update
    @comment = Comment.find(params[:id])
    @user = @comment.user
    @comment.update(comment_params)
    redirect_to @user.timeline
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
