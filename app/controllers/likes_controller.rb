class LikesController < ApplicationController

  before_filter :store_referer

  def create
    @user = current_user
    @liking = params[:liking_type].singularize.classify.constantize.find(params[:liking_id])
    @like = Like.create(liking: @liking, user: @user)
    flash[:success] = "Successfully liked!"
    redirect_to referer
  end

  def destroy
    @like = Like.find_by(user_id: params[:user_id], liking_id: params[:liking_id], liking_type: params[:liking_type].capitalize)
    @like.destroy
    redirect_to referer
  end


end
