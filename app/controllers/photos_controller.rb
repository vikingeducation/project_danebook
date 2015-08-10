class PhotosController < ApplicationController
  before_action :find_user
  before_action :require_current_user, only: [:new, :create, :destroy]

  def new
    @photo = Photo.new(user_id: current_user.id)
  end

  def index
    @photos = @user.uploaded_photos
  end

  def create
    @photo = Photo.new(whitelist_photo_params)
    @photo.user_id = params[:user_id]
    if @photo.save
      flash[:success] = "Successfully uploaded photo to your timeline!"
      redirect_to user_photos_path(current_user)
    else
      flash[:notice] = "Couldn't upload photo to your timeline because #{@photo.errors.full_messages}"
      redirect_to user_photos_path(current_user)
    end
  end

  # def destroy
  #   @post = Post.find(params[:id])
  #   if @post.destroy
  #     flash[:success] = "Post deleted Successfully!"
  #     redirect_to user_posts_path(current_user)
  #   else
  #     flash[:notice] = "Couldn't delete post, try again."
  #     redirect_to user_posts_path(current_user)
  #   end
  # end


  private

    def require_current_user
      unless current_user == @user
        flash[:notice] = "You cannot perform this action as a different user."
        redirect_to user_posts_path(@user)
      end
    end

    def find_user
      @user = User.includes(:profile, :friends).find(params[:user_id])
    end

    def whitelist_photo_params
      params.require(:photo).permit(:user_id, :uploaded_file)
    end
end
