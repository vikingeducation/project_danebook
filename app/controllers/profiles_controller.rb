class ProfilesController < ApplicationController

  def show
    @user = User.find_by_id(params[:user_id])
  end

  def edit
    @profile = current_user.profile
  end

  def set_profile_pic
    @photo = Photo.find_by_id(params[:photo_id])
    @profile = current_user.profile
    @profile.update(profile_pic_id: @photo.id)
    flash[:success] = "Hope ya dig your new profile pic!"
    redirect_to @photo
  end

  def unset_profile_pic
    @photo = Photo.find_by_id(params[:photo_id])
    @profile = current_user.profile
    @profile.update(profile_pic_id: nil)
    flash[:success] = "Da profile pic has been annihilated. Back to default for you!"
    redirect_to @photo
  end

  def set_cover_photo
    @photo = Photo.find_by_id(params[:photo_id])
    @profile = current_user.profile
    @profile.update(cover_photo_id: @photo.id)
    flash[:success] = "Hope ya dig your new cover photo!"
    redirect_to @photo
  end

  def unset_cover_photo
    @photo = Photo.find_by_id(params[:photo_id])
    @profile = current_user.profile
    @profile.update(cover_photo_id: nil)
    flash[:success] = "Da cover photo has been annihilated. Back to default for you!"
    redirect_to @photo
  end

end
