class PhotosController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @profile = @user.profile
    @photos = @user.photos
  end

  def new
    @user = User.find(params[:user_id])
    @photo = current_user.photos.build
  end

  def create
    @photo = current_user.photos.build(photo_params)
    if @photo.save
      flash[:success] = "Photo uploaded!"
      redirect_to user_photos_path(current_user)
    else
      flash[:warning] = @photo.errors.full_messages
      render :new
    end
  end

  def show
    @photo = Photo.find(params[:id])
    @profile = @photo.user.profile
  end

  def photo_params
    params.require(:photo).permit(:image)
  end
end
