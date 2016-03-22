class LikesController < ApplicationController

  def create
    params_id = "#{params[:likeable]}_id".downcase.to_sym
    @parent = params[:likeable].constantize.find(params[params_id])
    @parent.likes.create(author_id: current_user.id)
    @current_user = current_user
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def destroy
    like = Like.find(params[:id])
    @parent = like.likeable
    like = Like.find(params[:id]).destroy
    @current_user = current_user
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
end
