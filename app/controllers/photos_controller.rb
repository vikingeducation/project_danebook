class PhotosController < ApplicationController

  def index
    @user = User.includes(:photos).find_by_id(params[:user_id])
    @photos = @user.photos
  end

  def new
    @photo = Photo.new
  end

  def create
    new_photo = current_user.photos.build(white_list_params)
    if new_photo.save
      flash[:success] = "Photo has been uploaded successfully"
      redirect_to photo_path(new_photo)
    else
      flash[:danger] = new_photo.errors.full_messages[0]
      redirect_back(fallback_location: fallback_location)
    end
  end

  def new_link_photo
    new_photo = current_user.photos.build
    new_photo.from_url(params[:image_url])
    if new_photo.has_no_errors? && new_photo.save
      flash[:success] = "Photo has been uploaded successfully"
      redirect_to photo_path(new_photo)
    else
      flash[:danger] = new_photo.errors.full_messages[0]
      redirect_back(fallback_location: fallback_location)
    end
  end

  def show
    @photo = Photo.includes(:user).find_by_id(params[:id])
  end


  private
    def white_list_params
      params.require(:photo).permit(:picture)
    end
end
