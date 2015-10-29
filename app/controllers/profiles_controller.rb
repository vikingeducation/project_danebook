class ProfilesController < ApplicationController

  before_action :require_current_user,  :except => [:index]


  def index
    response = Profile.search(params[:search])
    @users = response.map { |profile| profile.user }
  end


  def edit
    @profile = Profile.find_by_user_id(params[:user_id])
    @user = @profile.user
  end


  def update
    @profile = Profile.find_by_user_id(params[:user_id])
    @user = @profile.user

    if @profile.update(profile_params)
      flash[:success] = 'Profile updated!'
      redirect_to user_path(@user)
    else
      flash.now[:danger] = 'Sorry, there was an error.  Please try again.'
      render :edit
    end
  end


  private

    def require_current_user
      unless params[:user_id] == current_user.id.to_s
        flash[:danger] = "You're not authorized to do this!"
        redirect_to user_path(params[:user_id])
      end
    end

    def profile_params
      params.require(:profile).permit(:college,
                                      :hometown,
                                      :currently_lives,
                                      :telephone,
                                      :words_to_live_by,
                                      :description)
    end

end