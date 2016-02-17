class CommentsController < ApplicationController

  def create
    params_id = "#{params[:commentable]}_id".downcase.to_sym
    parent = params[:commentable].constantize.find(params[params_id])
    parent.comments.create(author_id: current_user.id, body: params[:body])
    redirect_to :back
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to :back
  end
end
