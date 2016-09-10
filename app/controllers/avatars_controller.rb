class AvatarsController < ApplicationController
  def new
    @photo = Photo.find_by_id(params[:img])
    current_user.avatar = nil
    current_user.avatar = @photo.picture
    if current_user.save
      flash[:success] = "Avatar set successfully"
    else
      flash[:danger] = "Avatar set failed :("
    end
    redirect_back(fallback_location: fallback_location)
  end
end
