class PhotosController < ApplicationController
  before_action :require_login

  def index
    @user = User.find(params[:user_id])
  end

  def new
    @user = User.find(params[:user_id])
    @photo = current_user.photos.build
  end

  def create
    unless params[:photo_url].empty?
      photo = current_user.photos.build

      photo.photo_url(params[:photo_url])
    else
      photo = current_user.photos.build(photo_params)
    end

    if photo.save
      flash[:success] = "You've successfuly uploaded a photo!"
      redirect_to user_photo_path(current_user, photo)
    else
      flash[:error] = "It failed to upload photo"
      render :new
    end
  end

  def show
    @user = User.find(params[:user_id])
    @photo = @user.photos.find(params[:id])
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to user_photos_path(current_user)
  end

  private
    def photo_params
      params.require(:photo).permit(:image)
    end
end
