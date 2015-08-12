class PhotosController < ApplicationController

def index
  @photos = Photo.where(user_id: object_owner.id)
end

def show
  @photo = Photo.find(params[:id])
end

def new
  @photo = Photo.new
end

def create
  if params[:commit] = "Use Web Photo"
    @photo = Photo.new(:user_id => params[:user_id])
    @photo.image_from_url(params[:image_url])
  else
    @photo = Photo.new(whitelisted_photo_params)
  end

  if @photo.save
    flash[:success] = "Photo Uploaded"
    redirect_to user_photos_path(current_user)
  else
    flash.now[:error] = "Failed to upload photo"
    render :new
  end
end

def destroy

end

private

def whitelisted_photo_params
  params.require(:photo).permit(:user_id, :image, :image_url)
end

end
