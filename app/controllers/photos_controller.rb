class PhotosController < ApplicationController

  before_action :set_user
  before_action :require_login
  before_action :set_photo, only: [:show, :destroy]

  def index
    @photos = find_current_page_user.photos
    @grouped_photos = @photos.ids.each_slice(4).to_a
    @num_groups = @grouped_photos.count
  end

  def new
    @photo = Photo.new
  end

  def create
    if params[:photo].nil?
      flash[:danger] = "Unable to upload photo - NO PHOTO SELECTED"
      redirect_to new_user_photo_path(@current_user)
    else
      @photo = @current_user.photos.build(whitelisted_photo_params)
      if @photo.save
        flash[:success] = "Success! You've successfully uploaded a photo!"
        redirect_to user_photo_path(@current_user, @photo)
      else
        flash[:danger] = "Unable to upload your photo - #{@photo.errors[:data].first}"
        render :new
      end
    end
  end

  def show
  end

  def destroy
    if @photo.user != current_user
      flash[:danger] = "You cannot delete other user's photos!"
      redirect_back(fallback_location: user_timeline_path(current_user))
    else
      if @photo.delete
        flash[:success] = "You've successfully deleted photo (this action cannot be undone)"
      else
        flash[:danger] = "Unable to delete photo"
      end
      redirect_to user_photos_path(current_user)
    end
  end

  private

  def whitelisted_photo_params
    params.fetch(:photo).permit( :user_id,
                                 :data
                               )
  end

  def set_photo
    @photo = Photo.find(params[:id])
  end
end
