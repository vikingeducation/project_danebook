class LikingsController < ApplicationController
  def create
    @profile = Profile.find(params[:id])
    @profile.likes.create(user_id: current_user.id)
    redirect_to user_path(current_user)
  end

  def destroy
    @liking = Liking.find(params[:id])
    @activity = @liking.likable
    @user = @liking.user
    if @liking.destroy
      redirect_to user_path(current_user)
    else
      redirect_to user_path(current_user)
    end
  end
end
