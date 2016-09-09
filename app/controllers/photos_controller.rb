class PhotosController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @photos = @user.photos
  end

  def new
    @user = User.find(params[:user_id])
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    @user = User.find(params[:user_id])

    if @photo.save

      flash[:notice] = "photo successfully created"
      redirect_to user_photo_path(@user,@photo)
    else
      flash[:notice] = "photo not created, fix your errors"
      render :new
    end
  end

  def show
    @photo = Photo.find(params[:id])
    @user = @photo.user

  end

  def update
    @photo = Photo.find(params[:id])
    @user = @photo.user
    if @photo.update(photo_params)
      flash[:notice] = "photo succesfully updated"
      redirect_to :back
    else
      flash[:notice] = "photo not updated, fix your errors"
      redirect_to :back
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @user = @photo.user

    if @photo.destroy
      flash[:success] = "Your photo has been deleted!"
    else
      flash[:error] = "Error! The photo lives on!"
    end
    redirect_to user_photos_path(@user)

  end

  def photo_params
    params.require(:photo).permit(:user_id, :data, :comments_attributes => [ :body, :commentable_id, :commentable_type, :commenter_id ])
  end

end
