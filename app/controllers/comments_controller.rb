class CommentsController < ApplicationController

  def destroy

    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:success] = "Your Comment has been deleted!"
    else
      flash[:error] = "Error! The Comment lives on!"
    end
    redirect_to :back
  end
end
