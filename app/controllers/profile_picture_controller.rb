class ProfilePictureController < ApplicationController
  def create
    set_instance_variables
    @photo = Photo.find(params[:photo_id])
    @user.profile_picture = @photo
    if @user.save 
      flash[:success] = "You successfully updated your profile picture."
      redirect_to user_timeline_path
    else
      flash[:error] = "There was a problem updating your profile picture."
      redirect_to user_photo_path(@user, @photo)
    end
  end

  def destroy
  end
end
