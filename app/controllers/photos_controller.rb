class PhotosController < ApplicationController


  def new
    @photo = current_user.photos.build
  end

  def index
    @user = User.find(params[:user_id].to_i)
    @photos = @user.photos
  end

  def create
    @photo = current_user.photos.build(whitelisted_photo_params)

    # @photo.comments.build
    if @photo.save
      flash[:success] = "Successfully upload photo"
    else
      flash[:error] = "Failed to upload photo"
    end
    redirect_to user_photos_path(current_user)
  end

  def show
    @photo = Photo.find(params[:id])
    @comment = Comment.new
  end

  def destroy
    photo = Photo.find(params[:id])
    if photo.destroy
      flash[:success] = "Successfully deleted photo"
    else
      flash[:error] = "Failed to delete photo"
    end
  end

  private

    def whitelisted_photo_params
      params.require(:photo).permit(:photo_data)
    end


end
