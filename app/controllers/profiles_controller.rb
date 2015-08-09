class ProfilesController < ApplicationController

  def show
    @profile = current_user.profile # We only hit the database once
  end

  def edit
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile
    if @profile.update(profile_params)
      flash[:success] = "Profile Updated!"
      redirect_to current_user
    else
      flash.now[:error] = @profile.errors.full_messages.first
      render :edit
    end

  end

  private

  def profile_params
    params.require(:profile).permit(:college,
                                    :hometown,
                                    :current_home,
                                    :mobile,
                                    :summary,
                                    :about,
                                    :user_id)
  end

end
