class PhotosController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    # @photos = @user.photos
  end

end
