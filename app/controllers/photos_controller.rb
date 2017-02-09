class PhotosController < ApplicationController

  def index
    @user = User.find(params[:user_id])
  end

  def new
    @photo = current_user.photos.build
  end

  def show
    @user = User.find(params[:user_id])
    @photo = Photo.find(params[:id])
  end

  def create
    if params[:photo][:url].present?
      @photo = current_user.photos.build
      @photo.picture_from_url(params[:photo][:url])
    else
      @photo = current_user.photos.build(photo_params)
    end

    if @photo.save
      flash[:success] = 'Photo added!'
      redirect_to user_photos_path(current_user)
    else
      flash[:warning] = @photo.errors.full_messages
      redirect_to user_photos_path(current_user)
    end
  end

  def update
    set_photos
    if current_user.save
      flash[:success] = "Photo set"
      redirect_to user_photos_path(current_user)
    else
      flash[:warning] = current_user.errors.full_messages
      redirect_to user_photos_path(current_user)
    end
  end

  def destroy
  end

  private

  def photo_params
    params.require(:photo).permit(:user_id, :url, :image, :delete_image)
  end

  def set_photos
    if params[:profile_photo_id]
      current_user.profile_photo = Photo.find(params[:profile_photo_id])
    elsif params[:cover_photo_id]
      current_user.cover_photo = Photo.find(params[:cover_photo_id])
    end
  end


end
