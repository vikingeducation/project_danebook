class ProfilesController < ApplicationController

  def update
    @user = current_user
    @profile = @user.profile
    set_foreign_key
    if @profile.save
      flash[:success] = "Profile updated"
      redirect_back(fallback_location: proc { user_path(@user) } )
    else
      flash[:error] = @profile.errors.full_messages
      redirect_back(fallback_location: proc { user_path(@user) } )
    end
  end

  private

  def set_foreign_key
    if params[:photo_id]
      @profile.photo_id = params[:photo_id]
    elsif params[:cover_photo_id]
      @profile.cover_photo_id = params[:cover_photo_id]
    end
  end

end
