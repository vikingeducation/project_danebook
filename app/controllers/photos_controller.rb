class PhotosController < ApplicationController
 def new
    @photo = Photo.new
  end

  def create
    @photo = current_user.photos.build(photo_params)
    if @photo.save 
      flash[:success] = 'Photo uploaded!'
      redirect_to user_photo_url(current_user, @photo) 
    else
     flash.now[:danger] = 'Something went wrong, please make sure the
      file is an image type'
      render :new
    end
  end

  def index
    @user = User.find(params[:user_id])
    @photos = @user.photos
    @variables = photo_slicer(@photos)
  end

  def show
    @user = User.find(params[:user_id])
    @photo = Photo.find(params[:id])
  end

  def destroy
    @photo = Photo.find(params[:id])
    if @photo.user == current_user
      @photo.destroy
      flash[:success] = 'Photo uploaded!'
    else
      flash[:danger] = 'Unauthorized Operation'
    end
    redirect_to user_photos_path(params[:user_id])
  end

  private
    def photo_params
      params.require(:photo).permit(:file)
    end

  def photo_slicer(array)
    sections = array.length / 4
    leftover = array.length % 4
    [sections, leftover, array.length]
  end

end


