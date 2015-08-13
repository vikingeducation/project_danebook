class PhotosController < ApplicationController

  before_action :require_login
  before_action :require_current_user, :except => [:index, :show]
  before_action :require_friend, :only => [:show]

  def index
    @photos = User.find(params[:user_id]).photos.includes(:user, :likes, :comments => [:likes, :user])
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = current_user.photos.build(photo_params)
    if @photo && @photo.save
      flash[:success] = "You uploaded a photo"
      redirect_to user_photo_path(params[:user_id], @photo)
    else
      flash[:error] = "There was an error saving your photo."
      @photo = Photo.new
      render :new
    end
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def destroy
    @photo = Photo.find(params[:id])
    if (current_user.id == @photo.user_id) && @photo.destroy
      flash[:success] = "Your photo was deleted!"
    else
      flash[:error] = "The photo was not deleted."
    end
    redirect_to user_photos_path(current_user)
  end

  private

  def photo_params
    return nil if params[:photo].nil?

    params_list =params.require(:photo).permit(:picture, :photo_link)

    if params_list[:photo_link]
      params_list[:photo_link] = nil unless valid_link?(params_list[:photo_link])
    end
    params_list

  end

  def valid_link?(link)
    regex = /(https?:\/\/)([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?/
    link.match(regex)
  end

  # check if current_user is friender of user
  def require_friend
    unless current_user.id.to_s == params[:user_id] ||
      current_user.friends.include?(User.find(params[:user_id]))

      flash[:error] = "You have to be a friend to view this."
      redirect_to user_photos_path(params[:user_id])
    end

  end
end
