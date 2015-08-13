class PhotosController < ApplicationController
  before_action :store_referer
  before_action :find_user
  before_action :require_friendship, only: [:show]
  before_action :require_current_user, only: [:new, :create, :destroy]

  def new
    @photo = Photo.new(user_id: current_user.id)
  end

  def index
    @photos = @user.uploaded_photos.includes(:uploader)
  end

  def create
    @photo = Photo.new(whitelist_photo_params)
    @photo.user_id = params[:user_id]
    if @photo.save
      flash[:success] = "Successfully uploaded photo to your timeline!"
      redirect_to user_photos_path(current_user)
    else
      flash[:notice] = "Couldn't upload photo to your timeline because #{@photo.errors.full_messages}"
      redirect_to user_photos_path(current_user)
    end
  end

  def show
    @photo = User.find(params[:user_id]).uploaded_photos.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    @user = User.find(params[:user_id])
    if @photo.uploader.id == params[:user_id]
      if params[:type] == "profile"
        @user.profile_photo = @photo
      elsif params[:type] == "cover"
        @user.cover_photo = @photo
      else
        flash[:notice] = "Unable to determine photo action."
      end

      if @user.save
        flash[:success] = "Successfully updated your photo!"
      else
        flash[:notice] = "Couldn't update your profile photo."
      end
      redirect_to user_photo_path(@user, @photo)
    else
      flash[:notice] = "A cover/profile photo must belong to the uploader"
      redirect_to user_photos_path(@user)
    end

  end

  def destroy
    @photo = Photo.find(params[:id])
    unless @photo.uploader == params[:user_id]
      if @photo.destroy
        flash[:success] = "Photo deleted Successfully!"
      else
        flash[:notice] = "Couldn't delete photo, try again."
      end
    else
      flash[:notice] = "You must own this photo to delete it."
    end
    redirect_to user_photos_path(current_user)
  end


  private

    def require_current_user
      unless current_user == @user
        flash[:notice] = "You cannot perform this action as a different user."
        redirect_to user_posts_path(@user)
      end
    end

    def require_friendship
      unless current_user == @user || @user.friends.find_by(id: current_user.id)
        flash[:notice] = "You must be friends with this user!"
        redirect_to user_photos_path(@user)
      end
    end

    def find_user
      @user = User.includes(:profile, :friends).find(params[:user_id])
    end

    def whitelist_photo_params
      params.require(:photo).permit(:user_id, :uploaded_file)
    end
end
