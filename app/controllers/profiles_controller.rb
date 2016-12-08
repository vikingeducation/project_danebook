class ProfilesController < ApplicationController

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update(profile_params)
      flash[:success] = "Profile Updated!"
      redirect_to @profile.user
    else
      flash.now[:danger] = "Update Failed!"
      render :edit
    end
  end

  def profile_params
    params.require(:profile).permit(:college, :hometown, :residence, :telephone, :summary, :about_me)
  end
end
