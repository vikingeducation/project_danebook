class CoverPhotosController < ApplicationController
  def create
    set_instance_variables
    @photo = Photo.find(params[:photo_id])
    @user.cover_photo = @photo
    if @user.save 
      flash[:success] = "You successfully updated your cover photo."
      redirect_to user_timeline_path
    else
      flash[:error] = "There was a problem updating your cover photo."
      redirect_to user_photo_path(@user, @photo)
    end
  end

  def destroy
  end
end
