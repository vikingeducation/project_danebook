class PhotosController < ApplicationController

  def new
    @photo = Photo.new
    @photo.user_id = current_user.id
  end

  def create
    @photo = Photo.new(whitelisted_photo_params)
    if @photo.save
      flash[:success] = "You've successfully uploaded the image"
      redirect_to photos_user_path(current_user)
    else
      flash.now[:danger] = "Please correct errors and resubmit the form"
      render :new
    end
  end

  def create_with_url
    if params[:url]
      @photo = Photo.new(user_id: current_user.id)
      @photo.image_from_url(params[:url])
      if @photo.save
        flash[:success] = "You've successfully uploaded the image"
        redirect_to photos_user_path(current_user)
      else
        flash.now[:danger] = "Please correct errors and resubmit the form"
        render :new
      end
    else
      render :new
    end

  end

  def show

  end

  private
  def whitelisted_photo_params
    params.require(:photo).permit(:image, :user_id)
  end

end
