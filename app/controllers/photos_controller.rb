class PhotosController < ApplicationController
  before_action :require_login
  before_action :require_current_user, only: [:new, :destroy]

  def new
    @photo = current_user.photos.build
  end

  def create
    photo = current_user.photos.build(photo_params)

    if photo.save
      flash[:success] = "You've successfuly uploaded a photo!"
      redirect_to photo
    else
      flash[:error] = "It failed to upload photo"
      render :new
    end
  end

  def show
    @photo = Photo.find(params[:id])
  end

  private
    def photo_params
      params.require(:photo).permit(:url, :avatar)
    end
end
