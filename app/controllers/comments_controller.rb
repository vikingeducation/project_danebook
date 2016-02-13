class CommentsController < ApplicationController

  def create
    parent = params[:commentable].constantize.find(params[:post_id])
    parent.comments.create(author_id: parent.user_id, body: params[:body])
    redirect_to :back
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to :back
  end
end
