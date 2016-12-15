class ProfilesController < ApplicationController
  before_action :current_user_profile

  def edit
    @profile = Profile.find(params[:id])
    @user =  @profile.user
    @profile_photo = @user.profile_photo
    @cover_photo = @user.cover_photo
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

  def current_user_profile
    unless signed_in_user? && params[:id] && params[:id].to_i == current_user.profile.id
      flash[:danger] = "Not authorized!"
      redirect_to timeline_user_path(current_user)
    end
  end

end
