class ProfilesController < ApplicationController

	before_action :require_login
	before_action :require_object_owner, :only => [:edit, :update, :destroy]

def show
	@profile = Profile.find_by_user_id(params[:user_id])
end

def edit
	@profile = Profile.find_by_user_id(params[:user_id])
end

def update
	@profile = Profile.find_by_user_id(params[:user_id])
	fail
	if @profile.update(whitelisted_profile_params)
		flash[:success] = "Updates saved"
		redirect_to user_profile_path(:user_id => @profile.user.id)
	else
		flash[:error] = "Unable to save profile"
		render :edit
	end
end

def destroy
end

private

def whitelisted_profile_params
	params.require(:profile).permit(:user_id,
																	:id,
																	:about_me,
																	:words_to_live_by,
																	:home_city,
																	:home_country,
																	:current_city,
																	:current_country,
																	:college,
																	:telephone,
																	:profile_photo_id,
																	:cover_photo_id)
end

end
