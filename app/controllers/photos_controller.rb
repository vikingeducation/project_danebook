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
    @photo = Photo.includes(:user, :comments => [{:author => :profile_photo}]).find(params[:id])
    @comments = @photo.comments.order(created_at: :desc);
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
    respond_to do |format|
      format.html { redirect_to timeline_user_path(current_user) }
      format.js { render :photo_like }
    end
  end

  def unlike
    @photo = Photo.find(params[:id])
    if @photo.likes.pluck(:user_id, :likable_id).include?([current_user.id, @photo.id])
      @photo.likes.destroy(@photo.likes.where("user_id = #{current_user.id} AND likable_type = 'Photo'"))
    end
    @profile = current_user.profile
    respond_to do |format|
      format.html { redirect_to timeline_user_path(current_user) }
      format.js { render :photo_unlike }
    end
  end

  private
  def whitelisted_photo_params
    params.require(:photo).permit(:image, :user_id)
  end

end
