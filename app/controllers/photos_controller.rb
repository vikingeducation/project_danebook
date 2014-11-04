class PhotosController < ApplicationController

	def index
		@user = User.find(params[:user_id])
		@photos = @user.photos
	end

	def new
		@user = current_user
		@photo = @user.photos.build # do I need anything else here?
	end

	def create
		# handle the url
    @photo = current_user.photos.build(photo_params)

    if @photo.save
      flash[:success] = "You've added a photo"
      redirect_to user_photos_path
    else
      flash[:error] = "Something has gone wrong with your upload"
      render :new
    end

	end

  def destroy
  end

	def show
		@user = User.find(params[:user_id])
		@photo = Photo.find(params[:id])
	end

  def photo_params
    params.require(:photo).permit(:photo)
  end

end
