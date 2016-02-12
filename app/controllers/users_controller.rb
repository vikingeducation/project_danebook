class UsersController < ApplicationController
  # before_action :require_logout, only: [:new]
  before_action :require_login, except: [:new, :create]
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
        flash[:success] = "You successfully signed in"
        redirect_to user_path(@user.id)
      else
        flash[:error] = "The sign up was not working"
        redirect_to user_path(@user.id)
      end
    else
      flash.now[:error] = "The sign up was not successful"
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def about
    
  end

  def photos

  end

  def friends
  end

  
  private

    def whitelisted_params
      params.require(:user).
      permit(:first_name, 
        :last_name, 
        :email, 
        :password, 
        :password_confirmation,
        :profile_attributes => [
            :birthday,
            :current_location,
            :hometown,
            :school,
            :motto,
            :about,
            :telephone])
    end

end
