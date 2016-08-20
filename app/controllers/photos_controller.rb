class PhotosController < ApplicationController
  before_action :set_instance_variables
  before_action :require_account_owner, only: [:destroy]

  def new
    @photo = Photo.new
  end

  def create
    @user = current_user
    @photo = @user.photos.build(whitelisted_params)
    if @photo.save 
      flash[:success] = "Your photo was uploaded successfully."
      redirect_to user_photo_path(@user, @photo)
    else
      flash[:error] = "There was a problem uploading your photo."
      redirect_to new_user_photo_path(@user)
    end
  end

  def index
    @photos = @page_owner.photos
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def destroy
    @photo = Photo.find(params[:id])
    if @photo.destroy 
      flash[:success] = "You successfully deleted the photo."
      redirect_to user_photos_path(current_user)
    else
      flash[:error] = "There was an error and your photo was not deleted." + @photo.errors.full_messages.join(', ')
      redirect_to user_photo_path(current_user, @photo)
    end
  end


  private

  def whitelisted_params
    params.require(:photo).permit(:file)
  end
end
