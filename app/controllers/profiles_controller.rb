class ProfilesController < ApplicationController
  before_action :set_profile, only: [:edit, :update]
  def edit
    @user = User.find(@profile.user_id)
    if current_user == @user
      set_profile
    else
      flash[:error] = "Ahh ahhhh ahh, you don't have permission to do this"
      redirect_to user_profile_path(@profile.id, @profile.id)
    end
  end

  def update
    if @profile.update(white_listed_profile_params)
      flash[:success] = "Your profile has been updated!"
      redirect_to user_profile_path(@profile.user_id, @profile.id)
    else
      flash.now[:error] = "Uhhh oh something went wrong trying to update your profile"
      render :edit
    end
  end

  def show
    @user = current_user
  end

  private

    def set_profile
      @profile = Profile.find(params[:id])
    end

    def white_listed_profile_params
      params.require(:profile).permit(:college, :hometown, :currently_lives, :telephone, :words_to_live_by, :about_me)
    end

end
