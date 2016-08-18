class PhotosController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @photos = @user.photos.all
  end

  def new
    @user = User.find(params[:user_id])
    @photo = @user.photos.build
  end

  def create
    user = User.find(params[:user_id])
    if user.photos.create(photo_params)
      flash[:success] = "Saved photo!"
      redirect_to user_photos_path
    else
      flash[:error] = "Photo not saved!"
    end
  end

  def show
    @photo = Photo.find(params[:id])
    @user = User.find(params[:user_id])
  end

  def destroy
    photo = Photo.find(params[:id])
    if photo.destroy
      flash[:success] = "Photo deleted"
      redirect_to user_photos_path
    else
      flash.now[:error] = "Unable to delete photo"
      render :show
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:image)
  end

end
