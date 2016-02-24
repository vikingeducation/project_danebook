class ImagesController < ApplicationController

  before_action :require_login
  before_action :require_current_user, :only => [:new, :create, :destroy]

  def index
    @user = User.find(params[:user_id])
    @images = @user.images
  end
  
  def new
    @user = User.find(params[:user_id])
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
     @user = User.find(params[:user_id])
     @image = Image.find(params[:id])
  end 

  def destroy

    @image = Image.find(params[:id])
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


  private
  def image_params
    params.require(:image).permit(
          :user_id,
          :picture,
          :image_url
    )
  end   
end
