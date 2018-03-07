class PhotosController < ApplicationController

  before_action :set_photo, only: [:edit, :update, :destroy]

  def index
    @user = User.find(params[:user_id])
    user_photos = @user.photos

    @photos = user_photos.paginate(page: params[:page], per_page: 15)
    @photo = user_photos.new
  end

  def create
    session[:return_to] ||= request.referer

    photo = current_user.photos.new(photo_params)
    authorize photo

    if photo.save
      redirect_to session.delete(:return_to), notice: 'Photo was successfully created.'
    else
      redirect_to session.delete(:return_to), alert: "There was a problem with your photo file. The file #{photo.errors.messages[:photo_data][0]}"
    end
  end

  def update
    session[:return_to] ||= request.referer

    if @photo.update(photo_params)
      redirect_to session.delete(:return_to), notice: 'Photo was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    session[:return_to] ||= request.referer

    authorize @photo
    @photo.destroy
    redirect_to session.delete(:return_to), notice: "Photo was successfully destroyed."
  end

  private

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def photo_params
    params.require(:photo).permit(:photo_data, :delete_photo_data)
  end

end
