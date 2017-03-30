class PhotosController < ApplicationController

  #before_action :require_object_owner, only: [:new, :create, :destroy]

  def index
    @user = User.find(params[:user_id])
    @photos = @user.photos.all
  end

  def new
    @photo = Photo.new
    @user = User.find(params[:user_id])
  end

  def show
    @photo = Photo.find(params[:id])
    @user = User.find(params[:user_id])
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.user_id = current_user.id
    if @photo.save
      redirect_to user_photos_path(current_user)
    else
      render :action => "new"
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    if @photo.destroy
      flash[:success] = "Photo deleted."
      redirect_to user_photos_path(current_user)
    else
      flash.now[:error] = "Unable to delete photo."
      redirect_to :back
    end
  end

  def serve
    @photo = Photo.find(params[:id])
    send_data(@photo.data, :type => @photo.mime_type,
                           :filename => "#{@photo.filename}.jpg",
                           :disposition => "inline")
  end

  private

    def photo_params
      params.require(:photo).permit(:user_id, :photo_data, :image)
    end
end
