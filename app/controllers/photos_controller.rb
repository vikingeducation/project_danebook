class PhotosController < ApplicationController
  before_action :require_current_user => [:create, :destroy]
  def index
    @photos = current_user.photos
    # @user = User.find(params[:user_id])
    # @posts = @user.posts.order(created_at: :desc)
    # @post = current_user.posts.build
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = current_user.photos.build(photo_params)
    if @photo.save
      # redirect_to user_posts_path(@post.user)
      flash[:success] = "Uploaded new photo!"
    else
      flash.now[:error] = "Failed to upload photo!"
      # redirect_to user_posts_path(current_user)
    end
  end

  private
  def photo_params
    params.require(:photo).permit(:user_id)
  end

  def is_authorized?
    if current_user.id.to_s != params[:user_id]
      session[:return_to] ||= request.referer
      redirect_to session.delete(:return_to), :flash => { error: 'You are not authorized to do this action.' }
    else
      true
    end
  end
end