class PhotosController < ApplicationController
  def create
    @profile = current_user.profile
    @photo = @profile.build_photo(label: params[:photo][:label], avatar: params[:photo][:avatar] )
    
    if @photo.save
      flash[:sucess] = "Photo was uploaded"

      redirect_to current_user
    else
      flash[:error] = "Photo failed to upload"
      render "users/new"
    end
  end

  private

    def white_listed_photo_params
      params.require(:photo).
        permit(:label, :avatar)
    end
end
