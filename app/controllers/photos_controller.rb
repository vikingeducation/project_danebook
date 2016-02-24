class PhotosController < ApplicationController
  before_action :require_login, only: [:new, :create, :show, :destroy]
  before_action :redirect_if_photo_url_invalid, only: [:create]
  before_action :require_photo_author, only: [:destroy]

  def index
    @user = User.find_by_id(params[:id])
    if @user
      @friendeds = @user.friendeds
      @profile = @user.profile
      @photos = @user.photos
    else
      flash[:danger] = "User doesn't exist man..."
      if signed_in_user?
        redirect_to user_path(current_user)
      else
        redirect_to signup_path
      end
    end
  end

  def new
    @user = current_user
    @friendeds = @user.friendeds
    @profile = @user.profile
    @photo = Photo.new
  end

  def create
      @photo = Photo.new(photo_params)
      @photo.user_id = current_user.id
      if @photo.save
        flash[:success] = "Successfully uploaded image!"
        redirect_to photos_path(id: current_user)
      else
        flash[:danger] = "Couldn't upload image!"
        redirect_to new_photo_path
      end
  end

  def show
    @user = User.find_by_id(params[:user_id])
    if @user
      @friendeds = @user.friendeds
      @profile = @user.profile
      @photo = Photo.find_by_id(params[:id])
    else
      flash[:danger] = "User doesn't exist man..."
      if signed_in_user?
        redirect_to user_path(current_user)
      else
        redirect_to signup_path
      end
    end
  end

  def destroy
    @photo = Photo.find_by_id(params[:id])
    if @photo.destroy
      flash[:success] = "You've deleted a picture!"
      redirect_to photos_path(id: current_user.id)
    else
      flash[:danger] = "Failed to delete a picture!"
      redirect_to photos_path(id: current_user.id)
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:photo)
  end

  def require_photo_author
    photoy = Photo.find_by_id(params[:id])
    unless photoy && photoy.user_id == current_user.id
      flash[:danger] = "You're not the photo's author!!!"
      redirect_to user_path(current_user)
    end
  end

  def redirect_if_photo_url_invalid
    file = photo_params[:photo]
    if file.is_a?(String)
      begin
        raise_error_if_not_image(file)
      rescue StandardError => e
        flash[:danger] = "URL invalid: " + e.to_s
        redirect_to new_photo_path
      end
    end
  end

  def raise_error_if_not_image(url)
    Timeout.timeout(10) do
      url = URI.parse(url)
      Net::HTTP.start(url.host, url.port) do |http|
        content_type = http.head(url.request_uri)["Content-Type"]
        unless ["image/jpeg", "image/gif", "image/png"].include?(content_type)
          raise "URL must be JPEG, GIF, or PNG image file"
        end
      end
    end
  end

end
