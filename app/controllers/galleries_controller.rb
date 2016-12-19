class GalleriesController < ApplicationController
  include UserCheck

  before_action :set_user
  before_action :correct_user, except: [:show]

  def index
    @galleries = @user.galleries
  end

  def show
    @gallery = Gallery.includes(images: [:post]).find_by(id: params[:id])
  end

  def new
    @gallery = @user.galleries.build
    5.times do
      @gallery.images.build
    end
  end

  def create
    @gallery = @user.galleries.build(whitelisted)
    if @gallery.save
      flash[:success] = ["New Gallery Created.", "Your images will be viewable after processing"]
      redirect_to user_gallery_path(current_user, @gallery)
    else
      flash.now[:danger] = ["something went, wrong.."]
      @gallery.errors.full_messages.each do |msg|
        flash.now[:danger] << msg
      end
      render :new
    end
  end

  def edit
    @gallery = Gallery.find_by(id: params[:id])
    if @gallery.title == "Profile Images"
      @gallery.images.build
    else
      5.times do
        @gallery.images.build
      end
    end
  end

  def update
    @gallery = Gallery.find_by(id: params[:id])
    size = @gallery.images.size
    if @gallery.update(whitelisted)
      flash[:success] = ["Gallery: #{@gallery.title} updated!"]
      check_count_change(size)
      profile_img_msg
      redirect_to user_gallery_path(current_user, @gallery)
    else
      flash.now[:danger] = ["something went, wrong.."]
      @gallery.errors.full_messages.each do |msg|
        flash.now[:danger] << msg
      end
      render :edit
    end
  end

  def destroy
    gallery = Gallery.find_by(id: params[:id])
    flash[:success] = ["#{gallery.title} gallery has been deleted."]
    gallery.destroy
    redirect_to user_galleries_path(@user)
  end

  private
    def check_count_change(size)
      if @gallery.images.size > size
        flash[:success] << "Your image has been uploaded." << "Your image will be viewable after processing"
      elsif @gallery.images.size < size
        flash[:success] << "Your image has been deleted."
      end
    end

    def profile_img_msg
      if params[:gallery][:images_attributes].any? {|k, v| v[:set_profile_photo] == "1"}
        flash[:success] << "Your New Profile Photo will be set after processing"
      end
    end

    def whitelisted
      params.require(:gallery).permit(
                                        :id,
                                        :title,
                                        :description,
                                        :user_id,
                                        { images_attributes: [
                                                                :id,
                                                                :gallery_id,
                                                                :picture,
                                                                :url,
                                                                :description,
                                                                :set_profile_photo,
                                                                :_destroy
                                                              ]
                                        }
                                    )
    end
end
