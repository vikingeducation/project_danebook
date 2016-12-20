class ProfilesController < ApplicationController

  def edit
    @user = current_user
    @profile = Profile.where(user_id: current_user.id).first
  end

  def update
    @profile = Profile.where(user_id: current_user.id).first
    
    if @profile.update(profile_params)
      flash[:success] = "Profile Updated!"
      redirect_to @profile.user
    else
      flash.now[:danger] = "Update Failed!"
      render :edit
    end
  end

  def profile_params
    params.require(:profile).permit(:college, :hometown, :residence, :telephone, :summary, :about_me, :profile_photo_id, :cover_photo_id)
  end
end
