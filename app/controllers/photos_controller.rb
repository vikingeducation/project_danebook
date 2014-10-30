class PhotosController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @photos = @user.photos
  end

  def new
    @user = User.find(params[:user_id])
    @photo = @user.photos.build
  end

  def create
    @user = User.find(params[:user_id])
    @photo = @user.photos.build(photo_params)

    if @photo.save
      flash[:success] = "Saved new photo."
      redirect_to user_photos_url(@user)
    else
      flash[:error] = "Failed to upload."
      render :new
    end
  end

  def create_from_url
    @user = User.find(params[:user_id])
    @photo = @user.photos.build
    @photo.picture_from_url(photo_params)
  end

  def show
  end

  def destroy
  end

  private

  def photo_params
    params.require(:photo).permit(:image, :url)
  end
end
