class PhotosController < ApplicationController
  before_action :set_user, except: [:show]

  def index
    @photos = @user.photos.order(created_at: :desc)
  end

  def show
    @photo = Photo.find(params[:id])
    @user = @photo.user
    @comments = @photo.comments
    @comment = current_user.comments.build
  end

  def new
    @photo = current_user.photos.build
  end

  def destroy
    begin
      if (@photo = current_user.photos.find(params[:id])) && @photo.destroy
        flash[:success] = "Photo deleted!"
        redirect_to user_photos_path(@user)
      else
        flash[:danger] = "Photo could not be deleted!"
        go_back
      end
    rescue ActiveRecord::RecordNotFound
      flash[:danger] = "Photo could not be deleted!"
      go_back
    end
  end

  def create
    @photo = current_user.photos.build(photo_params)
    if @photo.save
      flash[:success] = "Photo uploaded successfully!"
    else
      flash[:danger] = "Failed to upload photo"
    end

    redirect_to user_photos_path(@user)
  end

  private

  def photo_params
    params.require(:photo).permit(:image)
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
