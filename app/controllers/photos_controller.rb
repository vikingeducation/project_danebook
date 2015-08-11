class PhotosController < ApplicationController

  before_action :require_login
  before_action :require_current_user, :except => [:index, :show]
  before_action :require_friend, :only => [:show]

  def index
    @photos = User.find(params[:user_id]).photos
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = current_user.photos.build(photo_params)

    if @photo.save
      flash[:success] = "You created a photo"
      redirect_to user_photo_path(@photo)
    else
      flash[:error] = "There was an error saving your photo."
      @photo = Photo.new
      render :new
    end
  end

  def show
    @photo = Photo.find(params[:id])
    send_data(@photo.picture,
              :disposition => "inline")
  end

  private

  def photo_params
      params.require(:photo).permit(:picture, :photo_link)
  end

  def require_friend
    unless User.find(params[:user_id]).friends.include?(current_user)|| current_user.id.to_s == params[:user_id]
      flash[:error] = "You have to be a friend to view this."
      redirect_to user_photos_path(params[:user_id])
    end
  end
end
