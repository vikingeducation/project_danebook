class PhotosController < ApplicationController
  before_action :require_login
  before_action :redirect_if_invalid_user
  before_action :redirect_if_photo_url_invalid, :only => [:create]
  before_action :require_current_user, :only => [:new, :create, :destroy]
  before_action :require_is_friend, :only => [:show]
  before_action :set_photo, :only => [:show, :destroy]
  before_action :require_user_is_photo_user, :only => [:create, :destroy]

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
        :user_id
      )
  end

  def redirect_if_photo_url_invalid
    file = photo_params[:file]
    if file.is_a?(String)
      begin
        raise_error_if_not_image(file)
      rescue StandardError => e
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
    unless current_user == @user || current_user.friend?(@user)
      flash[:error] = 'You must be friends to do that'
      redirect_to_referer user_photos_path(@user)
    end
  end

  def raise_error_if_not_image(url)
    Timeout.timeout(10) do
      url = URI.parse(url)
      Net::HTTP.start(url.host, url.port) do |http|
        content_type = http.head(url.request_uri)['Content-Type']
        unless ['image/jpeg', 'image/gif', 'image/png'].include?(content_type)
          raise 'URL must be an JPEG, GIF, or PNG image file'
        end
      end
    end
  end

  def require_user_is_photo_user
    if action_name == 'create' && current_user.id != photo_params[:user_id].to_i
      redirect_to_referer(
        new_user_photo_path,
        :flash => {:error => 'You cannot create a photo for another user'}
      )
    elsif action_name == 'destroy' && current_user.id != @photo.user_id
      redirect_to_referer(
        new_user_photo_path,
        :flash => {:error => 'You cannot destroy a photo for another user'}
      )
    end
  end
end


