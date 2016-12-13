class PhotosController < ApplicationController

  def new
    @photo = Photo.new
    @photo.user_id = current_user.id
  end

  def create
    @photo = Photo.new(whitelisted_photo_params)
    if @photo.save
      flash[:success] = "You've successfully uploaded the image"
      redirect_to photos_user_path(current_user)
    else
      flash.now[:danger] = "Please correct errors and resubmit the form"
      render :new
    end
  end

  def create_with_url
    if params[:url]
      @photo = Photo.new(user_id: current_user.id)
      @photo.image_from_url(params[:url])
      if @photo.save
        flash[:success] = "You've successfully uploaded the image"
        redirect_to photos_user_path(current_user)
      else
        flash.now[:danger] = "Please correct errors and resubmit the form"
        render :new
      end
    else
      render :new
    end
  end

  def show
    @photo = Photo.includes(:user).find(params[:id])
    @user = @photo.user
    @profile_photo = @photo.user.profile_photo
    @comment = Comment.new
  end

  def profile
    @photo = Photo.find(params[:id])
    current_user.profile_photo = @photo
    current_user.save!
    redirect_to photo_path(@photo)
  end

  def cover
    @photo = Photo.find(params[:id])
    current_user.cover_photo = @photo
    current_user.save!
    redirect_to photo_path(@photo)
  end

  # def update
  #   photo = Photo.find(params[:id])
  #   if photo && params[:profile_user_id]
  #     current_user.photos.update_all(:profile_user_id => nil)
  #     if photo.update_attribute(:profile_user_id, params[:profile_user_id])
  #       flash.now[:success] = "Successfully updated profile photo"
  #     else
  #       flash.now[:danger] = "Something went wrong during updating photo"
  #     end
  #   elsif photo && params[:cover_user_id]
  #     current_user.photos.update_all(:cover_user_id => nil)
  #     if photo.update_attribute(:cover_user_id, params[:cover_user_id])
  #       flash.now[:success] = "Successfully updated cover photo"
  #     else
  #       flash.now[:danger] = "Something went wrong during updating photo"
  #     end
  #   else
  #     flash.now[:danger] = "Something went wrong during updating photo"
  #   end
  #   redirect_to photos_user_path(current_user);
  # end

  def destroy
    photo = Photo.find(params[:id])
    if photo
      photo.destroy
      flash[:success] = "photo deleted!"
      redirect_to photos_user_path(current_user);
    else
      redirect_to photos_user_path(current_user);
    end
  end

  def like
    @photo = Photo.find(params[:id])
    unless @photo.likes.pluck(:user_id, :likable_id).include?([current_user.id, @photo.id])
      @photo.likes << Like.new(user_id: current_user.id, likable_type: "Photo")
    end
    @profile = current_user.profile
    redirect_to timeline_user_path(current_user)
  end

  def unlike
    @photo = Photo.find(params[:id])
    if @photo.likes.pluck(:user_id, :likable_id).include?([current_user.id, @photo.id])
      @photo.likes.destroy(@photo.likes.where("user_id = #{current_user.id} AND likable_type = 'Photo'"))
    end
    @profile = current_user.profile
    redirect_to timeline_user_path(current_user)
  end

  private
  def whitelisted_photo_params
    params.require(:photo).permit(:image, :user_id)
  end

end
