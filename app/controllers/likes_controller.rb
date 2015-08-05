class LikesController < ApplicationController

  def create
    user = User.find(params[:user_id])
    @like = Like.new({likeable_type: params[:likeable_type],likeable_id: params[:likeable_id], user_id: current_user.id})
    flash[:alert] = "You already liked this, no need to do it again" unless @like.save
    redirect_to user_timeline_path(user)
  end

  def destroy
    user = User.find(params[:user_id])
    @like = Like.search_record(params[:likeable_type], params[:likeable_id], current_user.id)
    if @like
      @like.destroy
    else
      flash[:alert] = "You already unliked this, no need to do it again"
    end
    redirect_to user_timeline_path(user)
  end


end
