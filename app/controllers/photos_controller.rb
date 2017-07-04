class PhotosController < ApplicationController
  before_action :require_current_user, only: [:new, :create, :destroy, :set_profile, :set_cover]
  before_action :set_user

  def index
  end

  def show
    if current_user?(@user.id) || @user.friends_with?(current_user.id)
      @photo = @user.photos.find(params[:id])
    else
      redirect_to root_path
    end
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = current_user.photos.build(photo_params)
    if @photo.save
      flash[:success] = "Photo uploaded successfully"
      redirect_to user_photos_path(current_user)
    else
      flash[:danger] = "Failed to upload photo"
      render :new
    end
  end

  def destroy
    @photo = current_user.photos.find(params[:id])
    if @photo.delete
      flash[:success] = "Photo deleted successfully"
      redirect_to user_photos_path(current_user)
    else
      flash[:danger] = "Failed to delete photo"
      redirect_back(:fallback_location => root_path)
    end

  end

  def set_profile
    @photo = current_user.photos.find(params[:photo_id])
    current_user.profile.profile_photo = @photo
    if current_user.save
      flash[:success] = "Profile photo updated successfully"
    else
      flash[:danger] = "Failed to update profile photo"
    end
    redirect_back(:fallback_location => root_path)
  end

  def set_cover
    @photo = current_user.photos.find(params[:photo_id])
    current_user.profile.cover_photo = @photo
    if current_user.save
      flash[:success] = "Cover photo updated successfully"
    else
      flash[:danger] = "Failed to update cover photo"
    end
    redirect_back(:fallback_location => root_path)
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def photo_params
    params.require(:photo).permit(:asset)
  end

end
