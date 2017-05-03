class PhotosController < ApplicationController
  before_action :set_user, only: [:index, :new, :create]
  skip_before_action :authenticate_user!, only: [:new, :index, :show, :create]

  def index
    @photos = @user.photos
  end

  def new
    return redirect_to user_photos_path(@user) unless is_self?
    @photo = Photo.new
  end

  def create
    return redirect_to user_photos_path(@user) unless is_self?
    @photo = current_user.photos.build(photo_params)
    if @photo.save
      flash[:success] = "Your photo was successfully added"
      redirect_to user_photos_path(@user)
    else
      flash[:error] = "Your photo could not be added"
      redirect_to upload_user_photos_path(@user)
    end
  end

  def show
    @photo = Photo.find(params[:id])
    @user = @photo.user
    return redirect_to user_photos_path(@user) unless @user.friendees.include?(current_user) || is_self?
    @comment = @photo.comments.build
  end

  def destroy
    @photo = Photo.find(params[:id])
    @user = @photo.user
    return redirect_to photo_path(@photo) unless is_self?
    if @photo.destroy
      flash[:success] = 'Success! Your photo was deleted!'
      redirect_to user_photos_path(@user)
    else
      flash[:error] = "You cannot delete that photo"
      redirect_to photo_path(@photo)
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def photo_params
    if params[:photo]
      params.require(:photo).permit(:image, :user_id)
    end
  end


end
