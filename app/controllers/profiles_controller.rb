class ProfilesController < ApplicationController

  before_action :require_login

  def show
    @profile = Profile.find_by_user_id(params[:user_id])
  end

  def edit
    @profile = Profile.find_by_user_id(params[:user_id])
  end

  def update
    @profile = Profile.find_by_user_id(params[:user_id])
    if @profile.update(profile_params)
      flash[:success] = "Updated successfully"
      redirect_to user_profile_path
    else
      flash[:error] = "Unable to save profile"
      render :edit
    end
  end

  private

    def profile_params
      params.require(:profile).permit(:user_id, :hometown, :college, :current_city, :words_to_live_by, :about_me, :telephone)
    end

end
