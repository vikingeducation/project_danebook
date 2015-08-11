class PhotosController < ApplicationController

  before_action :require_login

  def index
    @user = User.includes(:photos).find(params[:user_id])
    @photos = @user.photos
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = current_user.photos.build(photo_params)
    @photo.pic_from_url(params[:photo][:img_url]) if params[:photo][:img_url].length > 5
    if @photo.save
      flash[:success] = "Photo successfully posted"
    else
      flash[:error] = @photo.errors.full_messages.first
    end
    redirect_to user_photos_path(current_user)
  end

  def show
    @photo = Photo.find(params[:id])
    @comment = Comment.new
  end

  def destroy
    @photo = Photo.find(params[:id])
    if @photo.user == current_user
      @photo.destroy
      flash[:success] = "Your photo was deleted successfully"
    else
      flash[:error] = "You cannot delete another person's photos!"
    end
    redirect_to user_photos_path(current_user)
  end

  def set_as_profile
    @photo = Photo.find(params[:photo_id])
    current_user.profile_pic = @photo.photo
    current_user.save
    redirect_to user_photos_path(current_user)
  end

  def set_as_cover
    @photo = Photo.find(params[:photo_id])
    current_user.cover_photo = @photo.photo
    current_user.save
    redirect_to user_photos_path(current_user)
  end

  private

  def photo_params
    params.require(:photo).permit(:photo, :img_url)
  end

end
