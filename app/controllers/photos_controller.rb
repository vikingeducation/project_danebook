class PhotosController < ApplicationController
  before_action :require_current_user => [:create, :destroy]
  def index
    @photos = current_user.photos
    @user = current_user
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = current_user.photos.build(photo_params)
    if @photo.save
      redirect_to photos_path
      flash[:success] = "Uploaded new photo!"
    else
      flash.now[:error] = "Failed to upload photo!"
      redirect_to photos_path
    end
  end

  def destroy
    @user = current_user
    @user.avatar = nil
    if @user.save
      redirect_to photos_path
      flash[:success] = "Deleted photo!"
    else
      flash.now[:error] = "Failed to delete photo!"
      redirect_to photos_path
    end
  end

  private
  def photo_params
    params.require(:photo).permit(:user_id, :avatar)
  end

  def is_authorized?
    if current_user.id.to_s != params[:user_id]
      session[:return_to] ||= request.referer
      redirect_to session.delete(:return_to), :flash => { error: 'You are not authorized to do this action.' }
    else
      true
    end
  end
end