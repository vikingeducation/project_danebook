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
  end

  def show
    @user = User.find(params[:user_id])
    @photo = Photo.find(params[:id])
  end

  private

  def photo_params
    params.require(:photo).permit(:image)
  end

end
