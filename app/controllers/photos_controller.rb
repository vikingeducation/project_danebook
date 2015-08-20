class PhotosController < ApplicationController

  before_action :require_current_user, :except => [:index, :show]


  def index
    @user = User.find(params[:user_id])
    @photos = @user.photos.limit(16)
  end


  def new
    @user = current_user
    @photo = current_user.photos.build
  end


  def create
    @photo = current_user.photos.build(photo_params)
    if @photo.save
      flash[:success] = "Photo successfully uploaded!"
      redirect_to user_photo_path(current_user, @photo)
    else
      flash.now[:danger] = "Photo not saved. Please try again."
      @user = current_user
      render :new
    end
  end


  def show
    @photo = Photo.find(params[:id])
    @user = @photo.owner
  end


  private

    def photo_params
      params.require(:photo).permit(:photo, :photo_from_url)
    end


    def require_current_user
      unless params[:user_id] == current_user.id.to_s
        flash[:danger] = "You're not authorized to do this!"
        redirect_to user_posts_path(params[:user_id])
      end
    end

end
