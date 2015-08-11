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
    @photo.pic_from_url(params[:photo][:img_url]) if params[:photo][:img_url]
    if @photo.save
      flash[:success] = "Photo successfully posted"
    else
      flash[:error] = @photo.errors.full_messages.first
    end
    redirect_to user_photos_path(current_user)
  end

  def show
    @photo = Photo.find(params[:id])
  end

  private

  def photo_params
    params.require(:photo).permit(:photo, :img_url)
  end

end
