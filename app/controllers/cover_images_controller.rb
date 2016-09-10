class CoverImagesController < ApplicationController
  def create
    @photo = Photo.find_by_id(params[:img])
    current_user.cover_image = nil
    current_user.cover_image = @photo.picture
    if current_user.save
      flash[:success] = "Cover image set successfully"
    else
      flash[:danger] = "Cover image set failed :("
    end
    redirect_back(fallback_location: fallback_location)
  end
end
