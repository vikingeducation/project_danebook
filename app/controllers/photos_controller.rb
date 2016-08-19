class PhotosController < ApplicationController
  before_action :require_current_user, only: [:destroy, :create]

  def index
    @profile = Profile.find(params[:profile_id])
    @photos = @profile.photos
    @user = @profile.user
  end

  def create
    @profile = Profile.find(params[:profile_id])
    @photo = @profile.photos.build(photo_params)
    if @photo.save
      flash[:success] = "Your photo has been added!"
      redirect_to user_profiles_path(current_user)
    else
      flash.now[:danger] = "Something went wrong. Your photo was not uploaded"
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