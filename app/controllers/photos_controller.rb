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

  def photo_params
    require(:photo).permit(:photo_data)
  end
end
