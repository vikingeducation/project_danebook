class PhotosController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @photos = @user.photos
  end

  def show
    @user = current_user
    @photo = Photo.find(params[:id])
  end

  def new
    @user = current_user
    @photo = current_user.photos.build
  end

  def create
    @user = current_user
    @photo = current_user.photos.build(photo_params)
    if @photo.save
      flash[:success] = "Photo uploaded"
      redirect_to @photo
    else
      flash.now[:error] = "Something went wrong while uploading"
      render :new
    end
  end

  def destroy
    @photo = current_user.photos.find(params[:id])
    if @photo.destroy
      flash[:success] = "Photo deleted"
      redirect_to user_photos_path(current_user)
    else
      flash[:error] = "Something went wrong when deleting the photo"
      redirect_to user_photos_path(current_user)
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:photo)
  end
end
