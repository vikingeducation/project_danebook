class PhotosController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @photos = @user.photos
  end

  def show
    @user = User.find(params[:user_id])
    @photo = Photo.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @photo = Photo.new
  end

  def create
    if params[:url] && url_with_image?(params[:url])
      @photo = current_user.photos.build
      @photo.image_from_url(params[:url])
    else
      @photo = current_user.photos.build(photo_params)
    end
    if @photo.save
      flash[:success] = "Congratulations! You have successfully ulpoaded a photo!"
      redirect_to user_photo_path(current_user, @photo)
    else
      flash[:danger] = "Error! We couldn't upload your photo" + "#{@photo.errors.full_messages}"
      render :new
    end
  end

  def destroy

  end


  private
  def photo_params
    params.permit( :image )
  end

end
