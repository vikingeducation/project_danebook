class ProfilesController < ApplicationController



  def edit

    @profile = Profile.find(params[:id])
    @user = @profile.user
  end

  def update
    @profile = Profile.find(params[:id])
    @user = @profile.user
    if @profile.update(profile_params)
      flash[:success] = "Profile updated"
      redirect_to profile_path(@profile)
    else
      flash[:error] = "Could not save"
      render :edit
    end
  end

  def timeline
    if params[:profile_id]
      @profile = Profile.find_by_id(params[:profile_id])
    else
      @profile = current_user.profile
    end
    @user = @profile.user
    @profile ||= Profile.find(current_user.id)
    @posts = @profile.posts.order("created_at DESC")
  end

  def show
    @profile = Profile.find(params[:id])
    @user = @profile.user
    @posts = @profile.posts.order("created_at DESC")
    render :about
  end

  private



  def profile_params
    params.require(:profile).permit(:college, :hometown, :current_town,
      :telephone, :words_to_live_by, :about_me)
  end

end
