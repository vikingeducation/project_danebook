class PhotosController < ApplicationController

  # create a belongs_to  cover, profile photo for profile. and add migration

  def index
    @photos = current_user.photos
  end

  def create
    which = params["photoable"].downcase
    if (which == "user")
      @photoable = params["photoable"].classify.constantize.find(params["user_id"]);
      @photo = @photoable.photos.build(whitelisted_photo_params)
      
    elsif (which == "profile")
      @photoable = params["photoable"].classify.constantize.find_by_user_id(params["user_id"])
      avatar = Photo.find(params[:photo_id]).avatar
      @photo = @photoable.build_photo()
      @photo.avatar = avatar;
    end  

    if @photo.save
        flash[:success] = "Photo was uploaded"
        redirect_to current_user
    else
      flash[:error] = "Photo did not load"
      render :index
    end
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def set_background
  end

  def set_profile
  end

  private

    def whitelisted_photo_params
      params.require(:photo).
        permit(:label, :avatar)
    end
    
end
