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

    if params[:photo][:url] != ""
      @photo = @user.photos.build
      @photo.image_from_url(params[:photo][:url])
    else
      @photo = @user.photos.build(photo_params)
    end

    if @photo.save
      flash[:success] = "Saved new photo."
      redirect_to user_photos_url(@user)
    else
      flash[:error] = "Failed to upload."
      render :new
    end
  end

  def show
    @user = User.find(params[:user_id])
    @photo = Photo.find(params[:id])
  end

  def destroy
    @photo = current_user.photos.find(params[:id])
    @user = current_user

    if @photo.destroy
      flash[:success] = "Unliked."
      redirect_to user_photos_url(@user)
    else
      flash[:error] = "Something went wrong with that unlike."
      render :show
    end

  end

  private

  def photo_params
    params.require(:photo).permit(:image, :url)
  end
end
