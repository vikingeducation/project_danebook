class ProfilesController < ApplicationController

  def show
    @profile = Profile.find_by_user_id(params[:user_id])
  end

  def edit 
    @profile = Profile.find_by_user_id(params[:user_id])
    if @profile.user_id==current_user.id
      
    else
      flash[:error]="Don't even think about it!"
      
      redirect_to user_profile_path(:id => @profile.id, :user_id => @profile.user.id)
    end
  end

  def update
    @profile = Profile.find_by_user_id(params[:user_id])
    if @profile.update(whitelisted_profile_params)
      
      flash[:success]="Updates saved"
      redirect_to user_profile_path(:id => @profile.id, :user_id => @profile.user.id)
    else
      flash[:error]="Unable to save profile"
      render :edit
    end
  end

  private

  def whitelisted_profile_params
    params.require(:profile).permit(:id, :user_id,
                                    :college,
                                    :hometown,
                                    :homecountry,
                                    :livesintown,
                                    :livesincountry,
                                    :phone,
                                    :wordsby,
                                    :wordsabout
                                    )

  end

end
