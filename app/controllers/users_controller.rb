class UsersController < ApplicationController
  # before_action :require_logout, only: [:new]
  before_action :require_login, except: [:new, :create, :show, :timeline]
  before_action :require_current_user, only: [:edit, :update, :destroy]


  def index
  end

  def new
    @user = User.new
    @user.build_profile
  end

  def create
    @user = User.new(whitelisted_params)
    if @user.save
      if sign_in(@user)
        User.send_welcome_email(@user.id)
        flash[:success] = "You successfully signed in"
        redirect_to @user
      else
        flash[:error] = "The sign up was not working"
        redirect_to @user
      end
    else
      flash[:error] = "The sign up was not successful"
      render :new
    end
  end

  def update
    if current_user.update( whitelisted_params )
      flash[:success] = "user updated"
      redirect_to current_user
    else
      flash[:error] = "user not updated"
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def avatar
    current_user.avatar = Photo.find(params[:photo_id])
    current_user.save
    redirect_to current_user
  end

  def cover_photo
    current_user.cover_photo = Photo.find(params[:photo_id])
    current_user.save
    redirect_to current_user
  end

  def timeline
    if signed_in_user?
      @current_user.posts.build
    end
    @user = User.find(params[:user_id])
    @friends = @user.sample_friends
  end

  def searches
    @matches = User.find_users(params[:search_name])
  end

  def friends
    @user = User.find(params[:user_id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end

  def newsfeed
    @posts = current_user.friended_users.includes(:posts).all.order("created_at DESC").map{ |u| u.posts }.flatten
  end
  
  private

    def whitelisted_params
      params.require(:user).
      permit(:first_name, 
        :last_name, 
        :email, 
        :password, 
        :password_confirmation,
        :photo_id,
        :cover_photo_id,
        :profile_attributes => [
            :gender,
            :birthday,
            :current_location,
            :hometown,
            :school,
            :motto,
            :about,
            :telephone])
    end

end
