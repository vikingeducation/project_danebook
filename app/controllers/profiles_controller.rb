class ProfilesController < ApplicationController

  def edit
    @profile = Profile.find(params[:id])
    @user =  @profile.user
  end

  def update
    @profile = Profile.find(params[:id])
    @user =  @profile.user
    if @profile.update(profile_params)
      flash[:success] = "Successfully, updated your profile!"
      redirect_to about_user_path(@user)
    else
      @user =  @profile.user
      flash.now[:danger] = "Failed, to updated your profile. Please correct the errors and resubmit"
      render :edit
    end
  end

  private
  def profile_params
      params.require(:profile).permit(:college, :hometown, :address, :phone,
                                      :status, :about, :user_id)
  end

end
