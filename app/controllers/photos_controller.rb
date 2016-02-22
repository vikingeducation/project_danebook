class PhotosController < ApplicationController

  def serve
    @photo = Photo.find(params[:photo_id])
    send_data(@photo.data, type: @photo.mime_type, filename: "#{@photo.filename}.jpg", disposition: "inline")
  end

  def index
    @photos = Photo.find_by_user_id(params[:user_id])
  end


end
