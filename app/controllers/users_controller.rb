class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :is_authorized?, only: [:edit, :update, :destroy]

  skip_before_action :require_login, :only => [:new, :create]
  before_action :require_current_user, :only => [:edit, :update, :destroy]

  def index
    # @users = User.all
    # @users = User.search(params[:query])
    @users = User.joins(:profile).search(query_params[:query])
    render 'search'
  end

  def new
    @user = User.new
    @profile = @user.build_profile
  end

  def create
    @user = User.new(user_params)
    if @user.save

      permanent_sign_in(@user)
      User.delay.send_welcome_email(@user.id)
      flash[:success] = "Created new user!"
      redirect_to edit_user_path(@user)
    else
      flash.now[:error] = "Failed to Create User!"
      redirect_to root_path
    end
  end

  def show
    @user = User.find(params[:id])
    @profile = @user.profile
  end

  def edit
     @user = User.find(params[:id])
     @profile = @user.profile
  end

  def update
    if current_user.update(user_params)
      flash[:success] = "Updated user details!"
      redirect_to user_path(current_user.id)
    else
      flash.now[:error] = "Failed to update user details!"
      render :edit
    end
  end

  def profile_photo
    @photo = Photo.find(params[:id])
    @user = User.find(params[:user_id])
    @user.profile_photo_id = @photo.id
    if @user.save 
      flash[:success] = "Photo is now your profile photo"
      redirect_to photo_path(@photo)
    else
      flash[:success] = "Failed to make photo your profile photo"
      redirect_to photo_path(@photo)
    end
  end

  def cover_photo
    @photo = Photo.find(params[:id])
    @user = User.find(params[:user_id])

    @user.cover_photo_id = @photo.id
    if @user.save 
      flash[:success] = "Photo is now your cover photo"
      redirect_to photo_path(@photo)
    else
      flash[:success] = "Failed to make photo your cover photo"
      redirect_to photo_path(@photo)
    end
  end

  def search 
    # @users = User.search(params[:query])
    @users = Profile.search(query_params[:query])
  end


  private
    # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def query_params 
    params.permit(:query => [:firstname, :lastname])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :profile_photo_id, :cover_photo_id,
      :profile_attributes =>
                            [:id,
                             :firstname,
                             :lastname,
                             :birthday,
                             :gender,
                             :telephone,
                             :college,
                             :hometown,
                             :currently_lives,
                             :words_to_live_by,
                             :about_me])
  end

  def is_authorized?
    if current_user.id.to_s != params[:id]
      redirect_to user_path(current_user), :flash => { error: 'You are not authorized to do this action.' }
    end
  end
end
