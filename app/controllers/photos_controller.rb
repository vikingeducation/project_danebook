class PhotosController < ApplicationController
  before_action :get_user

  def index
  end

  def create
    photo = current_user.photos.new(photo_params)
    photo.save
    redirect_to user_photos_path(current_user)
  end

  def destroy
    if @photo.user_id == current_user.id
      @photo = Photo.find(params[:id])
      @photo.destroy
      redirect_to user_photos_path(@user)
    else
      flash[:error] = "You can only delete your own photos"
      redirect_to user_photos_path(@user)
    end
  end

  def new

  end

  def show
    @photo = Photo.find(params[:id])
  end

  private

  def get_user
    @user = Profile.find(params[:user_id]).user
    @profile = @user.profile
  end

  def photo_params
    params.require(:photo).permit(:picture)
  end
end