class ProfilesController < ApplicationController
  before_action :require_current_user, only: [:edit, :update]

  def show
    @user = User.find(params[:user_id])
    @profile = @user.profile
  end

  def edit
    @user = current_user
    @profile = current_user.profile
  end

  def update
    @user = current_user
    @profile = current_user.profile
    @profile.photo = @user.photos.find(params[:photo_id]) if params[:photo_id]
    @profile.cover_photo = @user.photos.find(params[:cover_photo_id]) if params[:cover_photo_id]
    if params[:profile] && @profile.update_attributes(profile_params)
      flash[:success] = "Profile updated"
      redirect_to user_profile_path(@user)
    elsif @profile.save
      flash[:success] = "Photo updated"
      redirect_to @user
    else
      flash[:error] = "Something went wrong when saving your profile"
      render :edit
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:school,
                                    :hometown,
                                    :current_town,
                                    :phone_number,
                                    :quotes,
                                    :about) if params[:profile]
  end
end
