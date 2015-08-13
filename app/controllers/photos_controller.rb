class PhotosController < ApplicationController

  def index
    @user = User.find(params[:user_id]) if params[:user_id]
    @user ||= current_user
    @photos = @user.photos
  end

  def new
    @photo = Photo.new
  end

  def create
    user = current_user
    @photo = user.photos.build(photo_params)
    if @photo.save
      flash[:success] = "Your photo is uploaded!"
      redirect_to @photo
    else
      flash[:error] = "Your photo cannot be uploaded!"
      render :new
    end
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def destroy
    @photo = Photo.find(params[:id])
    user = @photo.user
    if user == current_user && @photo.destroy
      flash[:success] = "Your photo has been deleted!"
      redirect_to photos_path
    else
      flash.now[:error] = "Cannot delete your photo!"
      render :show
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:user_photo)
  end
end
