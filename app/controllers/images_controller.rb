class ImagesController < ApplicationController

  before_action :require_login
  before_action :require_current_user, :only => [:new, :create, :destroy]
  before_action :set_user, only: [:index, :show, :new]
  before_action :set_image, only: [:show, :destroy]

  #before_action :redirect_if_image_url_invalid, :only => [:create]

  def index
    @images = @user.images
  end
  
  def new
    @image = @user.images.build
  end 

  def create

    if params[:image][:image_url] && !params[:image][:image_url].empty?
      @image = Image.new
      @image.image_from_url(params[:image][:image_url])
    else
      @image = Image.new(image_params)
    end

    @image.user_id = params[:user_id]
    
    if @image.save
       flash[:success] = "Photo saved!"
    else 
      flash[:alert] = "Could not  save your photo! "
    end

    redirect_to :back

  end 

  def show
  end 

  def destroy

    @image.picture.destroy 
    @image.picture.clear
    
    if @image.destroy
      flash[:success] = "Photo deleted"
      redirect_to images_path(user_id: params[:user_id])
    else
      flash[:alert] = "Could not delete"
      redirect_to :back
    end
  end 


  def set_user
    if !@user = User.find_by_id(params[:user_id])
      flash[:alert] = "No such user!"
      redirect_to root_url
    end   
  end

  def set_image
    if !@image = Image.find_by_id(params[:id])
      flash[:alert] = "No such image!"
      redirect_to :back
    end   
  end

  private
  def image_params
    params.require(:image).permit(
          :user_id,
          :picture,
          :image_url
    )
  end

end