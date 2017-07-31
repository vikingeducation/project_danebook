class PhotosController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @photos = @user.photos
  end

  def index
    @user = User.find(params[:user_id])
    @photos = @user.photos
  end

  def new
    @user = User.find(params[:user_id])
    @photo = Photo.new
  end

  def create
    @user = User.find(params[:user_id])
    @photo = @user.build(user_params)
    if @photo.save
      sign_in(@photo)
      flash[:success] = "Congratulations! You have successfully ulpoaded a photo!"
      redirect_to @photo
    else
      flash[:danger] = "Error! We couldn't upload your photo" + "#{@photo.errors.full_messages}"
      render :new
    end
  end

  def destroy

  end


  private
  def photo_params
    params.require(:photo).permit( :image )
  end

end
