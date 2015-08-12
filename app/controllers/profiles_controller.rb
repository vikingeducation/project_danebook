class ProfilesController < ApplicationController

  def index
    user = User.find(params[:user_id])
    @profile = user.profile
  end

  def edit
    @profile = current_user.profile
  end

  def update
    if current_user.profile.update(profile_params)
      
      # current_user.save
      flash[:success] ="Profile updated successfully!"
      redirect_to user_profiles_path(current_user)
    else
      flash.now[:error] = "Profile failed to update"
      render :edit
    end
  end


  private

    def profile_params
      params.require(:profile).permit(:college_name, :hometown, :current_home, :telephone, :words_to_live_by, :about_me, :profile_photo_id, :cover_photo_id)
    end
end
