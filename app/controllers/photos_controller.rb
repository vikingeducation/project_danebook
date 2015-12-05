class PhotosController < ApplicationController
  before_action :require_login
  before_action :redirect_if_invalid_user
  before_action :redirect_if_photo_url_invalid, :only => [:create]
  before_action :require_current_user, :only => [:new, :create, :destroy]
  before_action :require_is_friend, :only => [:show]
  before_action :set_photo, :only => [:show, :destroy]

  def index
    @user =  User.find(params[:user_id])
    @photos = @user.photos
  end

  def show
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      flash[:success] = 'Photo created'
      redirect_to user_photos_path(@photo.user)
    else
      flash[:error] = 'Photo not created: ' +
        @photo.errors.full_messages.join(', ')
      redirect_to new_user_photo_path
    end
  end

  def destroy
    if @photo.destroy
      flash[:success] = 'Photo destroyed'
    else
      flash[:error] = 'Photo not destroyed: ' +
        @photo.errors.full_messages.join(', ')
    end
    redirect_to user_photos_path(current_user)
  end


  private
  def set_photo
    @photo = Photo.find_by_id(params[:id])
    redirect_to_referer(
      root_path,
      :flash => {:error => 'Invalid photo'}
    ) unless @photo
  end

  def photo_params
    params.require(:photo)
      .permit(
        :file,
        :user_id,
        :cover_photo_id,
        :profile_photo_id
      )
  end

  # https://bideowego.com/favicon-194x194.png
  # http://placehold.it/128x128
  # https://asdf.com
  # http://asdf.com
  # ftp://bideowego.com
  # ftps://bideowego.com
  # :
  # //
  def redirect_if_photo_url_invalid
    file = photo_params[:file]
    if file.is_a?(String)
      begin
        Timeout.timeout(10) {open(URI.parse(file).to_s)}
      rescue Exception => e
        flash[:error] = 'URL invalid: ' + e.to_s
        redirect_to new_user_photo_path
      end
    end
  end

  def redirect_if_invalid_user
    redirect_to_referer(
      root_path,
      :flash => {:error => 'Unable to display photos for that user'}
    ) unless User.exists?(params[:user_id])
  end

  def require_is_friend
    @user = User.find(params[:user_id])
    redirect_to user_path(@user) unless current_user == @user || current_user.friend?(@user)
  end
end


