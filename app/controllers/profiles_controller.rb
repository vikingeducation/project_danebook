class ProfilesController < ApplicationController
  def edit
    @user = User.find(params[:user_id])
  end

  def update
    @photo = Photo.find(params[:id])
    @user = @photo.user
    return redirect_to photo_path(@photo) unless is_self?
    type = params[:photo_type].downcase
    if current_user.profile.update(type.to_sym => @photo.image)
      flash[:success] = "Your #{type} photo has been updated"
    else
      flash[:error] = "You can't use that as your #{type} photo"
    end
    redirect_to user_photos_path(@user)

  end

  private

  def profile_params
    params.require(:user).permit(profile_attributes: [:id, :college, :hometown, :current_city, :telephone, :about, :quote])
  end

end
