class PhotosController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @photos = @user.photos.paginate(:page => params[:page], :per_page => 16)
  end

  def show
    @user = current_user
    @photo = Photo.find(params[:id])
  end

  def new
    @user = current_user
    @photo = current_user.photos.build
  end

  def create
    @user = current_user

    if params[:photo] && params[:photo][:url].present?
      @photo = current_user.photos.build
      @photo.photo_from_url(params[:photo][:url])
    elsif params[:photo] && params[:photo][:photo]
      @photo = current_user.photos.build(upload_photo_params)
    else
      @photo = current_user.photos.build
    end

    if @photo.save
      flash[:success] = "Photo uploaded"
      redirect_to @photo
    else
      flash.now[:error] = "Something went wrong while uploading"
      render :new
    end
  end

  def destroy
    @photo = current_user.photos.find(params[:id])

    @photo.destroy

    respond_to do |format|
      format.html { redirect_to user_photos_path(current_user), notice: "Photo deleted" }
      format.js { render :js => "window.location.href = '#{user_photos_path(current_user)}'" }
    end
  end

  private

  def upload_photo_params
    params.require(:photo).permit(:photo) if params[:photo][:photo]
  end
end
