class PhotosController < ApplicationController

  def new
    @user = current_user
    @photo = current_user.photos.build
  end

end
