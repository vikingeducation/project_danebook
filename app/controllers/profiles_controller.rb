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
    @profile = current_user.profile

    if @profile.update(whitelisted_params)
      flash[:success] = "Updated your profile."
      redirect_to [current_user, @profile]
    else
      flash[:error] = "Check your inputs. Something went wrong."
      render :edit
    end

  end

  private

  def whitelisted_params
    params.require(:profile).permit( :user_id,
                                     :day,
                                     :month,
                                     :year,
                                     :gender,
                                     :college,
                                     :hometown,
                                     :currently_lives,
                                     :telephone,
                                     :words_to_live_by,
                                     :about_me )
  end
end
