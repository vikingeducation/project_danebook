class PhotosController < ApplicationController

  def index
    @user = User.find(params[:user_id])
  end

  def new
    @user = User.find(params[:user_id])
    @photo = Photo.new
  end

  def create
    @photo = current_user.photos.build(photo_params)
    if @photo.save
      flash.notice = "Photo saved."
      redirect_to user_photos_path(current_user)
    else
      flash.notice = "Photo not saved."
      redirect_back(fallback_location: current_user)
    end
  end

  def destroy
    @profile = current_user.profile
    @profile.profile_photo_id = nil if @profile.profile_photo_id == params[:id].to_i
    @profile.cover_id = nil if @profile.cover_id == params[:id].to_i
    @profile.save
    @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to user_photos_path(current_user)
  end

  def show
    @user = User.find(params[:user_id])
    @photo = Photo.find(params[:id])
    @comment = Comment.new
  end

  private

  def photo_params
    params.require(:photo).permit(:image)
  end

end
