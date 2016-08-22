class ProfilesController < ApplicationController
  # before_action :set_profile, only: [:edit, :update]
  before_action :require_login, :except => [:show]

  def show
    @user = User.find(params[:user_id])
  end

  def edit
    if signed_in_user?
      @user = current_user
      @profile = @user.profile
    else
      redirect_to login_path
    end
  end

  def update
    if signed_in_user?
      @profile = @current_user.profile
      if @profile.update(white_listed_profile_params)
        flash[:success] = "Your profile has been updated!"
        redirect_to user_profile_path(@current_user)
      else
        flash.now[:error] = "Uhhh oh something went wrong trying to update your profile"
        render :edit
      end
    else
      redirect_to login_path
    end
  end

  private

    def set_profile
      @profile = current_user.profile
    end

    def white_listed_profile_params
      params.require(:profile).permit(:college, :hometown, :currently_lives, :telephone, :words_to_live_by, :about_me)
    end
end
