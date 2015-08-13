class PhotosController < ApplicationController
  
  before_filter :store_referer
  before_filter :find_profile, except: [:update, :create]

  def show
    @photo=Photo.find(params[:id])
  end

  def create
    @profile = Profile.find_by_user_id(current_user.id)
    @photo = Photo.new(photo_params) 
    @photo.user_id = current_user.id
    if @photo.save
      flash[:success] = "You just added a photo"
      redirect_to user_photos_path(current_user)
    else
      flash[:failure] = "Photo wasn't added"
      render :new
    end
  end
  
  def index
    @photos=Photo.where("user_id = ?",@profile.user_id)
  end

  def new
    @photo=Photo.new(user_id: current_user.id) 
  end


  def update
    @photo = Photo.find(params[:id])
    @profile = Profile.find_by_user_id(current_user.id)
    
    if params[:type] == "avatar"
      @profile.avatar_id = @photo.id
      @profile.save
    elsif params[:type] == "cover"
      @profile.cover_id = @photo.id
      @profile.save
    else
      flash[:failure]="Picture was not set"
    end
    redirect_to referer

  end

  def destroy
    @photo = Photo.find(params[:id])
    if @photo.destroy
      flash[:success] = "Photo deleted"
      redirect_to referer
    else
      flash[:success] = "Photo was not deleted"
      render :show
    end
  end

  
  private

  def find_profile
    @profile = Profile.find_by_user_id(params[:user_id])
  end

  def photo_params
    params.require(:photo).permit(:user_id,:photo)
  end
  
end

