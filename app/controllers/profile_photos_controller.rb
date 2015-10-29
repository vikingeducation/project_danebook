class ProfilePhotosController < ApplicationController

  before_action :require_current_user


  def update
    @user = User.find(params[:user_id])
    @photo = Photo.find(params[:photo_id])
    @user.profile_photo = @photo

    if @user.save
      flash[:success] = 'Profile photo updated!'
      redirect_to user_path(@user)
    else
      flash[:warning] = 'Sorry, there was an error. Please try again.'
      redirect_back_or_to(user_photo_path(@photo))
    end

  end


  private

    def require_current_user
      unless params[:user_id] == current_user.id.to_s
        flash[:danger] = "You're not authorized to do this!"
        redirect_to user_photos_path(params[:user_id])
      end
    end

end
