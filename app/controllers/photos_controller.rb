class PhotosController < ApplicationController

  before_action :require_login

  def index
    @user = User.includes(:photos).find(params[:user_id])
    @photos = @user.photos
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = current_user.photos.build(photo_params)
    if @photo.save
      flash[:success] = "Photo successfully posted"
      redirect_to user_photos_path(current_user)
    else
      str = ""
      @photo.errors.full_messages.each do |message|
        str += "<li>#{message}</li>"
      end
      flash.now[:error] = str.html_safe
      render :new
    end
  end

  def show
    @photo = Photo.find(params[:id])
    @comment = Comment.new
  end

  def destroy
    @photo = Photo.find(params[:id])
    if @photo.user == current_user
      @photo.destroy
      flash[:success] = "Your photo was deleted successfully"
    else
      flash[:error] = "You cannot delete another person's photos!"
    end
    redirect_to user_photos_path(current_user)
  end

  def set_as_profile
    @photo = Photo.find(params[:photo_id])
    current_user.profile_pic = @photo
    current_user.save
    redirect_to user_photos_path(current_user)
  end

  def set_as_cover
    @photo = Photo.find(params[:photo_id])
    current_user.cover_photo = @photo
    current_user.save
    redirect_to user_photos_path(current_user)
  end

  private

  def photo_params
    params.require(:photo).permit(:data, :img_url)
  end

end
