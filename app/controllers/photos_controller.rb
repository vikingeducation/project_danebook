class PhotosController < ApplicationController
  layout 'photos'

  before_action :require_login
  before_action :require_object_owner, only: [:new, :create, :destroy]
  # before_action :redirect_if_photo_url_invalid, :only => [:create]

  def serve
    @photo = Photo.find(params[:id])
    send_data(@photo.data, type: @photo.mime_type, filename: "#{@photo.filename}.jpg", disposition: "inline")
  end

  def index
    @photos = Photo.where(user_id: params[:user_id])
    @user = User.find_by_id(params[:user_id])
  end


  def show
    @photo = Photo.find(params[:id])
    @user = User.find_by_id(params[:user_id])
    @new_comment = Comment.new
  end

  def new
    @photo = Photo.new
    @user = User.find_by_id(params[:user_id])
  end


  def create
    # photo via url
    if params[:image_url]
      if params[:image_url].empty?
        flash.now[:error] = "Please select a file."
      else
        @photo = Photo.new(user_id: params[:user_id])
        @photo.image_from_url(params[:image_url])   
      end     

    # photo via file system
    elsif params[:photo]
      if params[:photo][:image].nil?
        flash[:error] = "Please select a file."
      else
        @photo = Photo.new(whitelisted_params)
      end
    end
    
    if @photo && @photo.save
      flash[:success] = "Photo uploaded."
      redirect_to user_photos_path(current_user)
    else
      flash.now[:error] = "Photo was not uploaded."
      redirect_to :back
    end

  end


  def destroy
    @photo = Photo.find(params[:id])
    if @photo.destroy
      flash[:success] = "Photo deleted."
      redirect_to user_photos_path(current_user)
    else
      flash[:error] = "Unable to delete photo."
      redirect_to :back
    end
  end





  private

  def whitelisted_params
    params.require(:photo).permit(:user_id, :image, :image_url)
  end

end
