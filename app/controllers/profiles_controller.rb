class ProfilesController < ApplicationController

  before_action :require_login, only: [:edit, :update]
  before_action :require_current_user, only: [:edit, :update]
  before_action :my_profile?, only: [:edit, :update]

  def show
    @profile = Profile.find(params[:id])
  end

  def edit
    @profile = current_user.profile
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update(profile_params)
      flash[:success] = "Updated the profile!"
      redirect_to profile_path(current_user.id)
    else
      flash.now[:danger] = "Failed to update profile!"
      render :edit
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:college, :from, :lives, :number, :words, :about)
  end

  def my_profile?
    unless Profile.find(params[:id]).user.id == current_user.id
      asdfdsafs
      flash[:error] = "You're not authorized to do this!"
      redirect_to signup_path
    end
  end
  helper_method :update_user_auth

end
