class PhotosController < ApplicationController
  layout 'photos'

  before_action :require_login
  before_action :require_object_owner, only: [:new, :create, :destroy]
  before_action :redirect_if_photo_url_invalid, :only => [:create]
​
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
​
​
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
    # @new_comment = Comment.new
  end

  def new
    @photo = Photo.new
    @user = User.find_by_id(params[:user_id])
  end


  def create
    if params[:photo][:image].nil? || params[:image_url].nil?
      flash[:error] = "Please select a file."
      redirect_to :back
    else
      @photo = Photo.new(whitelisted_params)
      if @photo.save
        flash[:success] = "Photo uploaded."
        redirect_to user_photos_path(current_user)
      else
        flash.now[:error] = "Photo was not uploaded."
        redirect_to :back
      end
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
