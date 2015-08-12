class ProfilesController < ApplicationController



  def edit
    if params[:id] == current_user.profile.id.to_s
      @profile = current_user.profile
      @user = current_user
      render :edit
    else
      redirect_to edit_profile_path(current_user.profile)
    end
  end

  def update

    if current_user.profile.id == params[:id]
      redirect_to edit_profile_path(current_user)
    else 
      @profile = current_user.profile
      if @profile.update(profile_params)
        flash[:success] = "Profile updated"
        redirect_to profile_path(@profile)
      else
        flash[:error] = "Could not save"
        render :edit
      end
    end
  end

  def timeline
   @profile = Profile.find_by_id(params[:profile_id])
   @profile ||= Profile.find(current_user.id)
   @user = @profile.user
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
      :telephone, :words_to_live_by, :about_me, :profile_pic, :cover_pic)
  end

end
