class PhotosController < ApplicationController
  ## HOW ARE YOU HANDELING PHOTOS THAT GET DELETED AND ARE PROFILE/COVER PHOTOS
  before_action :required_user_redirect, except: [:index, :show]
  def index
    @user = User.find_by_id(params[:user_id])
  end

  def show
    @photo = Photo.find_by_id(params[:id])
    @user = User.find_by_id(params[:user_id])
    @comment = Comment.new
  end

  def new
    @user = User.find_by_id(params[:user_id])
    @photo = Photo.new
  end

  def create
    @user = User.find_by_id(params[:user_id])
    @photo = @user.photos.build(photo_params)
    if @user.save
      flash[:notice] = "Photo added succesfully"
      redirect_to user_photos_path(@user)
    else
      flash[:alert] = "Photo could not be added"
      render :new
    end
  end

  private

    def photo_params
      params.require(:photo).permit(:image)
    end

end
