class PhotosController < ApplicationController
  before_action :require_current_user, only: [:destroy, :create]

  def index
    @user = User.find_by_id(params[:user_id])
    @photos = @user.photos
  end

  def create
    @user = User.find_by_id(params[:user_id])
    @photo = @user.photos.build(photo_params)
    if @photo.save
      flash[:success] = "Your photo has been added!"
      redirect_to user_profiles_path(current_user)
    else
      dsads
      flash[:danger] = "Something went wrong. Your photo was not uploaded"
      redirect_to user_profiles_path(current_user)
    end
  end

  def destroy
  end

  def new

  end

  def show
    @photo = Photo.find(params[:id])
  end

  private

  def photo_params
    params.require(:photo).permit(:picture, :user_id)
  end

end