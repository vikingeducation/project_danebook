class ProfilesController < ApplicationController
  before_action :require_login, except: [:new, :create]
  skip_before_action :require_login, only: [:new, :create]
  before_action :require_current_user, only: [:edit, :update]

  def edit
    @profile = current_user.profile
  end

  def update
    puts "update in profiles_controller"
    if current_user.profile.update(strong_profile_params)
      flash[:success] = "Profile updated!"
      redirect_to user_profile_path(current_user)
    else
      @profile = current_user.profile
      flash.now[:warning] = ["Could not update profile"]
      flash.now[:warning].concat(@profile.errors.full_messages)
      render :edit
    end
  end

  def show
    @profile = User.find(params[:user_id]).profile
    render :show
  end

  private

    def strong_profile_params
      # p params
      params.require(:profile).permit(:birthday, :college, :hometown, :currently_lives, :telephone, :words_to_live_by, :about_me, :photo, :background)
    end
end
