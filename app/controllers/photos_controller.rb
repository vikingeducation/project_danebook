class PhotosController < ApplicationController

  def index
    @user = User.find_by_id(params[:user_id])
  end

  def new
    @user = User.find_by_id(params[:user_id])
    @photo = Photo.new
  end

  def create
    @user = User.find_by_id(params[:user_id])
    @photo = @user.photos.build(photo_params)
    if @photo.save
      flash[:success] = "Holy carp, you successfully uploaded a photo!!!"
      redirect_to photos_path(user_id: @user.id)
    else
      flash.now[:error] = "Unsurprisingly, something goofed. Our apes are performing seppuku upon the thirsty altars of Amazon S3 in a desperate ritual action of penitence."
      render :new
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:photo_data, :owner_id)
  end

end
