class ProfilesController < ApplicationController
    before_action :require_login
    before_action :require_current_user, :only => [:update, :destroy]

    def show
      @user = User.find(params[:user_id])
      @profile = @user.profile
    end

    def edit
      @user = User.find(params[:user_id])
      @profile = @user.profile
    end

    def update
      @profile = current_user.profile
      if @profile.update_attributes(whitelisted_params)
        flash[:success] = "Profile Updated"
        redirect_to user_profile_url current_user
      else
        flash[:error] = "Try again"
        render :edit
      end
    end

    def destroy

    end

    private
      def whitelisted_params
        params.require(:profile).permit( :motto, :college, :residing, :phone, :hometown, :about,
                                       :gender,
                                       :first_name,
                                       :last_name)
      end
end
