class ProfilesController < ApplicationController

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
    if @profile.update(profile_params)
      flash[:success] = "Updated successfully"
      redirect_to user_profile_path(current_user)
    else
      flash[:error] = "Unable to save profile"
      render :edit
    end
  end

  private

    def profile_params
      params.require(:profile).permit(:user_id, :hometown, :college, :current_city, :words_to_live_by, :about_me, :telephone, :day, :month, :year, :gender)
    end

end
