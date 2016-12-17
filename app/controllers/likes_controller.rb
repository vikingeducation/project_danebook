class LikesController < ApplicationController

  before_action :require_login

  def create
    @user = User.find(params[:id])
    @like = Like.new(likeable_id: params[:likeable_id], likeable_type: params[:likeable_type], liker_id: current_user.id)
    if @like.save
      flash[:success] = "Liked"
      redirect_back( fallback_location: proc { user_path(@user) } )
    else
      flash[:error] = "Could not like post"
      redirect_back( fallback_location: proc { user_path(@user) } )      
    end
  end

  def destroy
    @user = User.find(params[:id])
    @like = Like.where(likeable_type: params[:likeable_type], likeable_id: params[:likeable_id], liker_id: current_user.id).first
    if @like.destroy
      flash[:success] = "Like destroyed"
      redirect_back( fallback_location: proc { user_path(@user) } )
    else
      flash[:error] = "Could not destroy like"
      redirect_back( fallback_location: proc { user_path(@user) } )    
    end
  end

end
