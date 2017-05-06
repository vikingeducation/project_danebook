class ProfilesController < ApplicationController
  def edit
    @user = User.find(params[:user_id])
  end

  def update
    require 'open-uri'
    @photo = Photo.find(params[:id])
    @user = @photo.user
    return redirect_to user_photos_path(@user) unless is_self?
    if request.path == cover_photo_path(@photo)
      if current_user.profile.update(cover: @photo.image)
        flash[:success] = "Your cover photo has been updated"
      else
        flash[:error] = "You can't use that as your cover photo"
      end
    elsif request.path == avatar_photo_path(@photo)
      current_user.profile.avatar = @photo.image
      if current_user.save
        flash[:success] = "Your avatar has been updated"
      else
        flash[:error] = "You can't use that as your avatar"
      end
    end

    redirect_to user_photos_path(@user)

  end

  def profile_params
    params.require(:user).permit(profile_attributes: [:id, :college, :hometown, :current_city, :telephone, :about, :quote])
  end

  def cover_params
  end




end
