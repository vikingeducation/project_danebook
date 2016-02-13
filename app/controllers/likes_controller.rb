class LikesController < ApplicationController

  def create
    parent = params[:likeable].constantize.find(params[:post_id])
    parent.likes.create(author_id: parent.user_id)
    redirect_to :back
  end

  def destroy
    Like.find(params[:id]).destroy
    redirect_to :back
  end
end
