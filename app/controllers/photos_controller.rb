class PhotosController < ApplicationController
  before_action :get_user

  def index
  end

  def create
    photo = current_user.photos.new(photo_params)
    photo.save
    redirect_to user_photos_path(current_user)
  end

  def new

  end

  private

  def get_user
    @user = Profile.find(params[:user_id]).user
    @profile = @user.profile
  end

  def photo_params
    params.require(:photo).permit(:picture)
  end
end