class PhotosController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    @photo = Photo.new
  end

  def create
    @user = User.find(params[:user_id])
    @photo = Photo.new(photo_params)
    if @photo.save
      flash[:success] = "Photo added!"
      redirect_to user_photos_path(@user)
    else
      flash[:error] = "There was a problem uploading your photo!"
      render :action => "new"
    end
  end

  def index
    @user = User.find(params[:user_id])
    @photos = Photo.where(:user_id => @user.id)
  end

  def show
    @user = User.find(params[:user_id])
    @photo = Photo.find(params[:id])
  end

  private

  def photo_params
    params.require(:photo).permit(:data, :user_id)
  end

end
