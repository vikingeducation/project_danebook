class PhotosController < ApplicationController
  before_action :require_current_user, only: [:destroy, :create]


  def index
    @user = User.find_by_id(params[:user_id])
    @photos = @user.photos
    unless both_friends?(@user)
      flash[:danger] = "You have to be friends with them to view their photos"
      redirect_back(fallback_location: root_path)
    end
  end

  def create
    @user = User.find_by_id(params[:user_id])
    @photo = @user.photos.build(photo_params) unless !params[:photo]
    if @photo && @photo.save 
      flash[:success] = "Your photo has been added!"
      redirect_to user_photos_path
    else
      flash[:danger] = "You need to choose a photo to upload"
      redirect_to user_photos_path
    end
  end

  def destroy
  end

  def new

  end

  def show
    @user = User.find_by_id(params[:user_id])
    @photo = Photo.find(params[:id])
  end

  private

  def photo_params
    params.require(:photo).permit(:picture, :user_id)
  end

end