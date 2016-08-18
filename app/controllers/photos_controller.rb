class PhotosController < ApplicationController
  skip_before_action :correct_user
  
  def new
    @photo = current_user.photos.build
  end

  def index
    @user = User.find(params[:id])
    @photos = @user.photos
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def create
    if @photo = current_user.photos.create(photo_params)
      flash[:success] = "Photo has been saved."
      redirect_to @photo
    else
      flash[:danger] = "Photo couldn't be saved."
      redirect_to new_photo_path
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    if @photo.destroy
      flash[:success] = "Photo has been deleted."
      redirect_to current_user.timeline
    else
      flash[:danger] = "Photo couldn't been deleted."
      redirect_to current_user.timeline
    end
  end

  private

    def photo_params
      params.require(:photo).permit(:photo_data)
    end

    def serve
      @photo = Photo.find(params[:id])
      send_data @photo.data, type: @photo.mime_type, filename: "#{@photo.filename}.jpg}", disposition: "inline"
    end
end
