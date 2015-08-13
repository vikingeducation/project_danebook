class PhotosController < ApplicationController
  # before_action :require_current_user, :only => [:edit, :update, :destroy, :new]

  def new
    @user = User.find(params[:user_id])
    @photo = Photo.new
  end

  def create
    @comment = Comment.new
    @photo = Photo.new(photo_params)
    if @photo.save
      flash[:success] = "Photo added!"
      redirect_to user_photos_path(@user)
    else
      flash[:error] = "There was a problem uploading your photo!"
      render :action => "new"
    end
  end

  def index
    @user = User.find(params[:user_id])
    @photos = Photo.where(:user_id => @user.id)
  end

  def show
    @user = User.find(params[:user_id])
    @photo = Photo.find(params[:id])
    @comment = Comment.new
  end

  def destroy
    @photo = Photo.find(params[:id])
    if @photo.destroy
      flash[:success] = "Photo deleted!"
      redirect_to timeline_path(current_user)
    else
      flash[:error] = "Unable to delete photo!"
      redirect_to timeline_path(current_user)
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:data, :user_id)
  end

end
