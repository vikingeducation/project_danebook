class PhotosController < ApplicationController
  before_action :require_current_user => [:create, :destroy, :profile_photo, :cover_photo]
  def index
    @photos = current_user.photos
    @user = current_user
  end

  def new
    @user = current_user
    @photo = Photo.new
  end

  def create
    # Get the picture or url depending on the method of upload
    if params[:url]
      @photo = current_user.photos.build
      @photo.picture_from_url(params[:url])
    else
      @photo = current_user.photos.build(photo_params)
    end

    if @photo.save
      redirect_to photos_path
      flash[:success] = "Uploaded new photo!"
      # This does show the flash message when the picture is uploaded
    else
      flash.now[:error] = "Failed to upload photo!"
      redirect_to photos_path
    end
  end

  def show
    @user = current_user
    @photo = Photo.find(params[:id])
  end

  def destroy
    @user = current_user
    @photo = Photo.find(params[:id])
    @photo.avatar = nil

    if @photo.destroy
      redirect_to photos_path
      flash[:success] = "Deleted photo!"
    else
      flash.now[:error] = "Failed to delete photo!"
      redirect_to photos_path
    end
  end

  def profile_photo
    @photo = Photo.find(params[:id])
    @user = current_user
    @user.profile_photo_id = @photo.id
    if @user.save 
      flash[:success] = "Photo is now your profile photo"
      redirect_to photo_path(@photo)
    else
      flash[:success] = "Failed to make photo your profile photo"
      redirect_to photo_path(@photo)
    end
  end

  def cover_photo
    @photo = Photo.find(params[:id])
    @user = current_user

    @user.cover_photo_id = @photo.id
    if @user.save 
      flash[:success] = "Photo is now your cover photo"
      redirect_to photo_path(@photo)
    else
      flash[:success] = "Failed to make photo your cover photo"
      redirect_to photo_path(@photo)
    end
  end

  private
  def photo_params
    params.require(:photo).permit(:user_id, :avatar)
  end

  def is_authorized?
    if current_user.id.to_s != params[:user_id]
      session[:return_to] ||= request.referer
      redirect_to session.delete(:return_to), :flash => { error: 'You are not authorized to do this action.' }
    else
      true
    end
  end
end