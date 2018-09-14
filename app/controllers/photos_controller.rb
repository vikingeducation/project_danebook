class PhotosController < ApplicationController

  before_action :set_user
  before_action :require_login

  def index
    @photos = current_page_user.photos
    @grouped_photos = @current_user.photo_ids.each_slice(4).to_a
    @num_groups = @grouped_photos.count

  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = current_user.photos.build(whitelisted_photo_params)
    if @photo.save
      flash[:success] = "Success! You've successfully uploaded a photo!"
      redirect_to user_photo_path(@current_user, @photo)
    else
      flash[:danger] = "Unable to upload your photo"
      render :new
    end
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def destroy
    @photo = Photo.find(params[:id])
    if @photo.user != current_user
      flash[:danger] = "You cannot delete other user's photos!"
      redirect_back(fallback_location: user_timeline_path(current_user))
    else
      if @photo.delete
        flash[:success] = "You've successfully deleted photo (this action cannot be undone)"
        redirect_to user_photos_path(current_user)
      else
        flash[:danger] = "Unable to delete photo"
        redirect_to user_photos_path(current_user)
      end
    end
  end

  private

  def whitelisted_photo_params
    params.require(:photo).permit(:user_id, :photo)
  end
end
