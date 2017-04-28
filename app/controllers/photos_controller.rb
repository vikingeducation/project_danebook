class PhotosController < ApplicationController
  before_action :set_user, only: [:index, :new, :create]
  skip_before_action :authenticate_user!, only: [:new]

  def index
    @photos = @user.photos
  end

  def new
    return redirect_to user_photos_path(@user) unless is_self?
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

end
