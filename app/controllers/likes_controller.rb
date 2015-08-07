class LikesController < ApplicationController

  before_action :require_login

  def create
    @liked = params[:liked_type].constantize.find(params[:liked_id])
    if @liked.likers << current_user
      flash[:success] = 'Liked!'
    else
      flash[:danger] = 'Error!'
    end
    redirect_to :back
  end


  def destroy
    if Like.find(params[:id]).destroy
      flash[:success] = 'Unliked!'
    else
      flash[:danger] = 'Error!'
    end
    redirect_to :back
  end

end
