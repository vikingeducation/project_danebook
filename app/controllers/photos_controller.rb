class PhotosController < ApplicationController

  # create a belongs_to  cover, profile photo for profile. and add migration

  def index
    @photos = current_user.photos
  end

  def create
    which_id = params["photoable"].downcase + "_id"
    if (which_id == "user_id")
      @photoable = params["photoable"].classify.constantize.find(params["user_id"]);
      @photo = @photoable.photos.build(white_listed_photo_params)
      
    elsif (which_id == "profile_id")
      picture = Photo.find(params[:photo_id]).dup
      attributes = picture.attributes.select do |attr, value|
        Photo.column_names.include?(attr.to_s) end

      
      @photoable = params["photoable"].classify.constantize.find_by_user_id(params["user_id"]);

      @photo = @photoable.build_photo(attributes);


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

    def white_listed_photo_params
      params.require(:photo).
        permit(:label, :avatar)
    end
    
end
