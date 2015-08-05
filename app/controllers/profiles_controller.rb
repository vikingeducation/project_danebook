class ProfilesController < ApplicationController
  def edit
    @user = User.find(params[:user_id])
    @profile = @user.profile
  end

  def update
    @profile = User.find(params[:user_id]).profile
    if @profile.update(profile_params)
      flash[:success] = "Profile updated"
      redirect_to user_profile_path(@profile.user)
    else
      flash[:error] = "Could not save"
      render :edit
    end
  end

  def show
    @user = User.find(params[:user_id])
    render :about
  end

  private

  def profile_params
    params.require(:profile).permit(:college, :hometown, :current_town,
                                    :telephone, :words_to_live_by, :about_me)
  end

end
