class PhotosController < ApplicationController
  
  def index
    @photos = Photo.all.where("user_id = #{params[:user_id]}").order("created_at DESC")
  end

  def new 
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)

    if @photo.save
      redirect_to @photo
    else
      render :new
    end
  end

  def show
  end


  private

 def photo_params
    params.require(:photo).permit(:file, :filename, :caption)
  end


end
