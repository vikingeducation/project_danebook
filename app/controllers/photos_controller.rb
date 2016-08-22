class PhotosController < ApplicationController


  def index
    @user = User.find(params[:id])
    @photos = @user.photos
  end

  def new
    @photo = current_user.photos.build
  end

  def show
    @photo = Photo.find(params[:id])
    @photo_id = @photo.id.to_s
    @user_id = @photo.user_id
    @comment = Comment.new
  end

  def create
    @photo = current_user.photos.build(photo_params)
    if @photo.save
      flash[:success] = "Your photo has been uploaded!"
      redirect_to photos_path(id: current_user)
    else
      flash[:danger] = "Your photo could not be uploaded"
      redirect_to photos_path(id: current_user)
    end
  end


  def update

  end

  def destroy

  end

  private

  def photo_params
    params.require(:photo).permit(:image)
  end
  
end
