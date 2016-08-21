class PhotosController < ApplicationController
  before_action :require_friends_with, only: [ :show ]

  def index
    @user = params[:user_id] ? User.find(params[:user_id]) : current_user
    @photos = @user.photos
    render 'static_pages/photos'
  end

  def new
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def create
    if photo_params[:image]
      @photo = current_user.photos.build(photo_params)
    else
      # @photo = current_user.photos.build.picture_from_url(photo_params[:url])
      @photo = Photo.create(user_id: current_user.id)
      @photo.picture_from_url(photo_params[:url])
    end
    if @photo.save
      flash[:success] = 'Photo uploaded'
      redirect_to @photo
    else
      flash[:error] = 'Unable to upload photo...'
      redirect_back(fallback_location: root_url)
    end
  end






  private
  def photo_params
    params.require(:photo).permit(:image, :url)
  end

  def require_friends_with
    @photo = Photo.find(params[:id])
    @user = @photo.user
    unless current_user.friends_with?(@user) || current_user == @user
      flash[:error] = 'Must be friends with this person to see their photo'
      redirect_back(fallback_location: root_url)
    end
  end
end
