class PhotosController < ApplicationController

  # create a belongs_to  cover, profile photo for profile. and add migration
  def create
    @profile = current_user.profile
    @photo = @profile.build_photo(white_listed_photo_params)
    
    if @photo.save
      flash[:success] = "Photo was uploaded"

      redirect_to current_user
    else
      flash[:error] = "Photo failed to upload"
      render "users/show"
    end
  end

  private

    def white_listed_photo_params
      params.require(:photo).
        permit(:label, :avatar)
    end
end
