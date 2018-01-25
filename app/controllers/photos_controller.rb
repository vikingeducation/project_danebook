class PhotosController < ApplicationController

  before_action :set_photo, only: [:edit, :update, :destroy]

  def index
    @user = User.find(params[:user_id])
    @photos = @user.photos
  end

  def create
    session[:return_to] ||= request.referer

    @photo = current_user.photos.new(photo_params)
    authorize @photo
    respond_to do |format|
      if @photo.save
        format.html { redirect_to session.delete(:return_to), notice: 'Photo was successfully created.' }
        format.json { render 'users/timeline', status: :created, location: session.delete(:return_to) }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    session[:return_to] ||= request.referer

    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to session.delete(:return_to), notice: 'Photo was successfully updated.' }
        format.json { render 'users/timeline', status: :ok, location: session.delete(:return_to) }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    session[:return_to] ||= request.referer

    authorize @photo
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to session.delete(:return_to), notice: "Photo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_photo
      @photo = Photo.find(params[:id])
    end

    def photo_params
      params.require(:photo).permit(:photo_data, :delete_photo_data)
    end

end
