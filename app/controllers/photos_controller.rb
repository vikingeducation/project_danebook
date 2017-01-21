class PhotosController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @photos = @user.photos.reversed
  end

  def new
    @user = User.find(params[:user_id])
    @photo = @user.photos.build
  end

  def create
    @user = current_user
    @photo = @user.photos.build(whitelisted_params)
    if @photo.save
      flash[:success] = "Photo added"
      redirect_to user_photos_path
    else
      flash[:error] = @photo.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:user_id])
    @photo = @user.photos.find(params[:id])
    @comment = @photo.comments.build
  end

  def destroy
    @user = current_user
    @photo = @user.photos.find(params[:id])
    if @photo.destroy
      flash[:success] = "Photo deleted"
      redirect_to user_photos_path
    else
      flash[:error] = "Could not delete photo"
      render :show
    end
  end

  private

  def whitelisted_params
    params.require(:photo).permit(:photo)
  end

end
