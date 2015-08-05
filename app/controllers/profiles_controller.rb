    class ProfilesController < ApplicationController
  def index
    @user = @current_user
  end

  def show

    @user = User.find(params[:user_id])
  end

  def edit
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile
    if @profile.update(whitelisted_profile_params)
      flash[:success] = "Successfully updated your profile"
      redirect_to user_profile_path
    else
      flash.now[:failure] = "Failed to update your profile"
      render :edit
    end
  end

  private

  def whitelisted_profile_params
    params.require(:profile)
    .permit(:birthday, :current_town, :hometown, :about_me, 
      :words_to_live_by, :college, :telephone)
  end
end
