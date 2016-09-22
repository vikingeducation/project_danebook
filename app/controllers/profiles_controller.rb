class ProfilesController < ApplicationController


  # before_action :require_current_user, :only => [:update]

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
    @user.update(user_params)
    @profile.update(profile_params)
    redirect_to user_profile_path(@user)
  end

  def photo
    current_user.profile.profile_photo_id = params[:format].to_i
    current_user.profile.save
    redirect_to user_path(current_user)
  end

  def cover
    current_user.profile.cover_id = params[:format].to_i
    current_user.profile.save
    redirect_to user_path(current_user)
  end

  def search
    @user = current_user
    @users = User.search(query_params[:query])
  end

  private

  def profile_params
    params.require(:profile).permit(:birthdate, :hometown, :current_residence, :telephone, :words_to_live_by, :about_me)
  end

  def user_params
    params.require(:user).permit(:email, :gender, :first_name, :last_name)
  end

  def query_params
    params.permit(query: [:first_name, :last_name])
  end

end
