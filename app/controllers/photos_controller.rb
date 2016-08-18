class PhotosController < ApplicationController
  skip_before_action :correct_user

  def new
    @photo = current_user.photos.build
  end

  def index
    @user = User.find(params[:id])
    @photos = @user.photos
    @like = Like.new(user_id: current_user.id)
    @comment = Comment.new(user_id: current_user.id)
  end

  def show
    @photo = Photo.find(params[:id])
    @user = @photo.user
    @comment = Comment.new(user_id: current_user.id)
    @like = Like.new(user_id: current_user.id)
  end

  def create
    if @photo = current_user.photos.create(photo_params)
      flash[:success] = "Photo has been saved."
      redirect_to @photo
    else
      flash[:danger] = "Photo couldn't be saved."
      redirect_to new_photo_path
    end
  end

  def update
    @photo = Photo.find(params[:id])
    @user = @photo.user
    if @photo.update(photo_params)
      if photo_params[:comments_attributes]
        flash[:success] = "Added a comment."
      elsif photo_params[:likes_attributes]
        flash[:success] = "You've liked this post!"
      else
        flash[:success] = "Photo updated."
      end
      redirect_to @user.timeline
    else
      flash[:danger] = "Couldn't update this post."
      redirect_to @user.timeline
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    if @photo.destroy
      flash[:success] = "Photo has been deleted."
      redirect_to current_user.timeline
    else
      flash[:danger] = "Photo couldn't been deleted."
      redirect_to current_user.timeline
    end
  end

  def serve
    @photo = Photo.find(params[:photo_id])
    send_data @photo.data, type: @photo.mime_type, filename: "#{@photo.filename}.jpg}", disposition: "inline"
  end

  private

    def photo_params
      params.require(:photo).permit(:photo_data,
                                   { comments_attributes: [:user_id,:body] },
                                   { likes_attributes: [:user_id,:_destroy] })
    end

end
