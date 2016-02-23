class PhotosController < ApplicationController
  before_action :require_login
  before_action :require_current_user, only: [:new, :destroy]


  def index
    @user = User.find(params[:user_id])
  end

  def new
    @user = User.find(params[:user_id])
    @photo = current_user.photos.build
  end

  def create
    if params[:photo_url]
      photo = current_user.photos.build
      photo.photo_url(params[:photo_url])
    else
      photo = current_user.photos.build(photo_params)
    end

    if photo.save
      flash[:success] = "You've successfuly uploaded a photo!"
      redirect_to user_photo_path(current_user, photo)
    else
      flash[:error] = "It failed to upload photo"
      render :new
    end
  end

  def show
    @user = User.find(params[:user_id])
    @photo = @user.photos.find(params[:id])
    @comment = @photo.comments.build
  end

  private
    def photo_params
      params.require(:photo).permit(:image)
    end
end
