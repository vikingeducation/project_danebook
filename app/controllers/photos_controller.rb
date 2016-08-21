class PhotosController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @photos = @user.photo_posts.order(created_at: :desc)
  end

  def new
    @user = User.find(params[:user_id])
    @user.photo_posts.build
  end

  def create
    if signed_in_user?
      current_user
      if @current_user.photo_posts.create(white_listed_photo_params)
        flash[:success] = "Photo uploaded successfully"
        redirect_to user_photos_path(@current_user)
      else
        flash[:error] = "Couldn't upload your photo"
        render :new
      end
    else
      redirect_to login_path
    end
  end

  def show
    @user = User.find(params[:user_id])
    @photo = Photo.find(params[:id])
  end

  private

    def white_listed_photo_params
      params.require(:photo).permit(:description, :file)
    end
end
