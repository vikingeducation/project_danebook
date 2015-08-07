class CommentsController < ApplicationController

  before_action :require_login

  def create
    @new_comment = Comment.new(comment_params)
    if @new_comment.save
      flash[:success] = "Comment created!"
    else
      flash[:danger] = "Comment not saved. Please try again."
    end
    redirect_to :back
  end


  private


    def comment_params
      params.require(:comment).permit(:body, :author_id, :post_id)
    end

end
