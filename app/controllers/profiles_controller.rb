class ProfilesController < ApplicationController

  def show
    @user = User.find(params[:user_id])
    @profile = @user.profile
  end

  def edit
    @user = User.find(params[:user_id])
    @profile = @user.profile
  end

  def update
    @user = User.find(params[:user_id])
    @profile = @user.profile
    User.update(user_params)
    Profile.update(profile_params)
    redirect_to user_profile_path(@user)
  end

  private

  def profile_params
    params.require(:profile).permit(:gender, :birthdate, :hometown, :current_residence, :telephone, :words_to_live_by, :about_me)
  end

  def user_params
    params.require(:user).permit(:email)
  end

end
