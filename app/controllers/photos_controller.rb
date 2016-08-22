class PhotosController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @profile = @user.profile
    @photo = @user.photos.build
    @photos = @user.photos
  end

  def create
    @user = User.find(params[:user_id])
    if params[:photo]
      @photo =  @user.photos.build(photo_params)
      @photo.save
      redirect_to user_photos_path(@user)
    else
      redirect_to user_photos_path(@user)
    end
  end

  def show
    @photo = Photo.find(params[:id])
    @owner = @photo.user
    @profile = @owner.profile
    @comment = @photo.comments.build
  end

  def update
    @photo = Photo.find(params[:id])
    @user = @photo.user
    if photo_params[:profile] == "true" && current_user.profile_pic
       current_profile = current_user.profile_pic
       current_profile.update(:cover => false)
    end
    if photo_params[:cover] == "true" && current_user.cover_pic
       cover = current_user.cover_pic
       cover.update(:cover => false)
    end
    @photo.update(photo_params)
    redirect_to user_photo_path(@user, @photo)
  end

  def destroy
    @photo = Photo.find(params[:id])
    @user = @photo.user
    @photo.destroy
    redirect_to user_photos_path(@user)
  end

  private

  def photo_params
    params.require(:photo).permit(:avatar, :profile, :cover)
  end

end
