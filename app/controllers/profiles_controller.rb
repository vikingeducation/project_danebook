class ProfilesController < ApplicationController

def show
	@profile = Profile.find(params[:id])
end

def edit
	@profile = Profile.find(params[:id])
end

def update
	@profile = Profile.find(params[:id])
	if @profile.update(whitelisted_profile_params)
		flash[:success] = "Updates saved"
		redirect_to user_profile_path(:id => @profile.id, :user_id => @profile.user.id)
	else
		flash[:error] = "Unable to save profile"
		render :edit
	end
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
																	:current_country)
end

end
