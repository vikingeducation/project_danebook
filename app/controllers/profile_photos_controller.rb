class ProfilePhotosController < ApplicationController

  def update
    @user = User.find(params[:user_id])
    @photo = Photo.find(params[:photo_id])
    @user.profile_photo = @photo

    if @user.save
      flash[:success] = 'Profile photo updated!'
      redirect_to user_path(@user)
    else
      flash.now[:warning] = 'Sorry, there was an error. Please try again.'
      redirect_back_or_to(user_photo_path(@photo))
    end

  end

end
