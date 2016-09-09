class ProfilesController < ApplicationController


  def create
    @profile = Profile.new(profile_params)
    @profile
    if @profile.save
      flash[:notice] = "Profile successfully created"

    else
      flash[:notice] = "profile has not saved"
    end
    @photo = Photo.find(profile_params[:photo_id])
    @user = User.find(profile_params[:user_id])
    redirect_to :back
  end

  def update
    @profile = Profile.find(params[:id])
    @profile.photo_id = profile_params[:photo_id]
    if @profile.save
      flash[:success] = "Your profile has been updated!"
    else
      flash[:error] = "Error! The profile was not changed!"
    end
    @photo = Photo.find(profile_params[:photo_id])
    @user = User.find(profile_params[:user_id])
    redirect_to :back

  end

  def profile_params
    params.permit(:user_id, :photo_id)
  end
end
