class ProfilesController < ApplicationController
  layout "profile"



  def show
    @profile = Profile.find_by_user_id(params[:user_id])
  end

  def edit
    @profile = Profile.find_by_user_id(params[:user_id])
  end


  def update
    @profile = find_by_user_id(params[:user_id])
    if @profile.update(whitelisted_params)
      flash[:success] = "Updates saved"
      redirect_to user_profile_path(@profile.user)
    else
      flash[:error] = "Unable to save profile"
      render :edit
    end
  end



  private
  def whitelisted_params
    params.require(:profile).permit(:user_id)
  end




end
