class PhotosController < ApplicationController

before_action :require_login
before_action :require_friendship_or_ownership
before_action :require_object_owner, only: [:new, :create, :destroy]

def index
  @photos = Photo.where(user_id: object_owner.id)
end

def show
  @photo = Photo.find(params[:id])
  @new_comment = Comment.new
end

def new
  @photo = Photo.new
end

def create
  @photo = Photo.new(whitelisted_photo_params)
  if @photo.save
    flash[:success] = "Photo Uploaded"
    redirect_to user_photos_path(current_user)
  else
    flash.now[:error] = "Failed to upload photo"
    render :new
  end
end

def destroy
  @photo = Photo.find(params[:id])
  if @photo.destroy
    flash[:success] = "Photo destroyed"
    redirect_to user_posts_path(current_user.id)
  else
    flash[:error] = "Unable to destroy photo"
    redirect_to :back
  end
end

private

def whitelisted_photo_params
  params.require(:photo).permit(:user_id, :image, :image_url)
end

def require_friendship_or_ownership
  unless object_owner.check_friend?(current_user) ||
  current_user == object_owner
    flash[:error] = "You must be a friend to view photos"
    redirect_to :back
  end
end

end
