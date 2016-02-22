class PhotosController < ApplicationController
  layout 'photos'

  before_action :require_login
  before_action :require_object_owner, only: [:new, :create, :destroy]


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
    # @new_comment = Comment.new
  end

  def new
    @photo = Photo.new
    @user = User.find_by_id(params[:user_id])
  end


  def create
    if params[:photo][:image].nil?
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
    params.require(:photo).permit(:user_id, :image)
  end

end
