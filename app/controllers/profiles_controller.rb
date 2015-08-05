class ProfilesController < ApplicationController
  def edit
    @user = User.find(params[:user_id])
    @profile = @user.profile
  end

  def update
    @profile = Profile.find(params[:id]).profile
    if @profile.update(profile_params)
      flash[:success] = "Profile updated"
      redirect_to user_profile_path(@profile.user)
    else
      flash[:error] = "Could not save"
      render :edit
    end
  end

  def timeline
   @profile = Profile.find(params[:profile_id])
   @posts = @profile.posts.order("created_at DESC")
 end

  def show
   @profile = Profile.find(params[:id])
   @posts = @profile.posts.order("created_at DESC")
   render :about
  end

  private

  def profile_params
    params.require(:profile).permit(:college, :hometown, :current_town,
                                    :telephone, :words_to_live_by, :about_me)
  end

end
