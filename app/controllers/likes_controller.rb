class LikesController < ApplicationController
  before_filter :store_referer
  def create
    @user = current_user
    @likable = get_likable
    @like = Like.create(likable: @likable, user: @user)
    flash[:success] = "Successfully liked!"
    redirect_to referer
  end

  def destroy
    @like = Like.find_by(user_id: params[:user_id], likable_id: params[:likable_id], likable_type: params[:likable_type].capitalize)
    @like.destroy
    redirect_to referer
  end

  private
    def get_likable
      params[:likable_type].singularize.classify.constantize.find(params[:likable_id])
    end
end
