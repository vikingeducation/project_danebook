class PhotosController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
    @photos = @user.photos
  end

  def new
    @user = User.find(params[:user_id])
    @photo = Photo.new
  end

  def show
    @user = User.find(params[:user_id])
    @photo = @user.photos.find(params[:id])
  end

  def create
    @photo = current_user.photos.build(photo_params)
    if @photo.save
      redirect_to user_photos_path
    else
      render action: 'new'
    end
  end

  def edit
  end

  def destroy
    @photo = current_user.photos.find(params[:id])
    
    if @photo.destroy
      redirect_to user_photos_path
    else
      render action: 'show'
    end
  end

  private
    def photo_params
      params.require(:photo).permit(:picture)
    end

end
