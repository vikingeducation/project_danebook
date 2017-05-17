class PhotosController < ApplicationController
  before_action :redirect_if_empty_form, only: [:create]

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
    if params[:photo] && params[:photo][:url]
      @photo = current_user.photos.build
      @photo.picture_from_url(params[:photo][:url])
    elsif params[:photo]
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
    if set_photo && current_user.save
      flash[:success] = "Photos updated!"
      redirect_to user_photos_path(current_user)
    else
      flash[:warning] = current_user.errors.full_messages
      redirect_to user_photos_path(current_user)
    end
  end

  def destroy
    photo = Photo.find(params[:id])
    if photo.destroy
      flash[:success] = 'Photo deleted!'
      redirect_to user_photos_path(current_user)
    else
      flash[:warning] = "Couldn't delete photo!"
      redirect_to user_photos_path(current_user)
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:user_id, :url, :image, :delete_image)
  end

  def set_photo
    if params[:profile_photo_id]
      current_user.profile_photo = Photo.find(params[:profile_photo_id])
    elsif params[:cover_photo_id]
      current_user.cover_photo = Photo.find(params[:cover_photo_id])
    end
  end

  def redirect_if_empty_form
    unless params[:photo]
      flash[:warning] = 'Empty form!'
      redirect_to new_photo_path
    end
  end

end
