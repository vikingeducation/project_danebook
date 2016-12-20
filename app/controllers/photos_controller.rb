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
      flash[:success] = "Photo Uploaded!"
      redirect_to user_photos_path
    else
      render action: 'new'
    end
  end


  def destroy

    @photo = Photo.find(params[:id])# current_user.photos.find(params[:id])
    if @photo.destroy
      redirect_to user_photos_path(current_user.id)
    else
      redirect_to user_photos_path(current_user.id)
    end
  end


  def set_avatar
    @photo = Photo.find(params[:photo_id])
    current_user.avatar = @photo
    redirect_to user_timeline_path(current_user)
  end

  def set_banner(photo)
    @photo = Photo.find(params[:id])
    current_user.banner = @photo
    redirect :back
  end

  private
    def photo_params
      params.require(:photo).permit(:picture)
    end


end
