class LikesController < ApplicationController

  def create
    params_id = "#{params[:likeable]}_id".downcase.to_sym
    parent = params[:likeable].constantize.find(params[params_id])
    parent.likes.create(author_id: current_user.id)
    redirect_to :back
  end

  def destroy
    Like.find(params[:id]).destroy
    redirect_to :back
  end
end
