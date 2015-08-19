class PhotosController < ApplicationController


  def index
    @user = User.find(params[:user_id])
    @photos = @user.photos
  end

  def new
    @user = current_user
    @photo = current_user.photos.build
  end


  def create
    #@photo = current_user.photos.build(photo_params)
    redirect_to user_photos_path(current_user)
  end


  private

    def photo_params
      params.require(:photo).permit(:photo)
    end

end
