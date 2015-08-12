class PhotosController < ApplicationController

  def show
    @profile = Profile.find_by_user_id(params[:user_id])
    @photos=Photo.where("user_id = ?",@profile.user_id)
  end

  def create
    @profile = Profile.find_by_user_id(current_user.id)
    @photo=Photo.new(photo_params) 
    @photo.user_id = current_user.id
    binding.pry
    if @photo.save
      flash[:success] = "You just added a photo"
      redirect_to user_photos_path(current_user)
    else
      flash[:failure] = "Photo wasn't added"
      render :new
    end
  end
  
  def index
    @profile = Profile.find_by_user_id(params[:user_id])
    @photos=Photo.where("user_id = ?",@profile.user_id)
  end

  def new
    @profile = Profile.find_by_user_id(params[:user_id])
    @photo=Photo.new(user_id: current_user.id) 
  end
  
  private
  def photo_params
    params.require(:photo).permit(:user_id,:photo_content_type, :photo_updated_at)
  end
  
end

