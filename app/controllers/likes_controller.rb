class LikesController < ApplicationController

  before_action :require_login

  def create

    like = Like.new(likes_params)

    if like.save
      flash[:success] = "Liked successfully!"
      redirect_to request.referrer
    else
      flash[:error] = "Could not like this. Please try again"
      redirect_to request.referrer
    end
  end

  def destroy
    like = Like.find(params[:id])
    like.destroy
    redirect_to request.referrer
  end

   

  def require_login
    unless current_user
      flash[:error] = "You must be logged in"
      redirect_to root_path # halts request cycle
    end
  end

  def likes_params
    {likeable_id: params[:likeable_id], likeable_type: params[:likeable_type],
     user_id: current_user.id}
   end

end
