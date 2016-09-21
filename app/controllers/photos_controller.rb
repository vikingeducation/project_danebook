class PhotosController < ApplicationController
  before_action :require_login, :except => [:index, :show]

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
      @user = current_user
      @photo =@user.photo_posts.create(white_listed_photo_params)
      if @photo
        flash[:success] = "Photo uploaded successfully"
        redirect_to user_photos_path(@current_user)
      else
        flash[:danger] = "Couldn't upload your photo"
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

  def destroy
    if @photo = Photo.find_by_id(params[:id])
      respond_to do |format|
        if @photo.destroy
          flash[:success] = "Your photo was destroyed"
          format.html { redirect_to user_photos_path(current_user) }

        else
          flash[:danger] = "Failed to destroy photo"
          format.html { redirect_to :back }
        end

      end
    else
      flash[:danger] = "Wrong coordinates"
      format.html { redirect_to user_photos_path(current_user) }
    end
  end

  private

    def white_listed_photo_params
      params.require(:photo).permit(:description, :file)
    end
end
