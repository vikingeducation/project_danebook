class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy, :show]
  before_action :require_login, except: [:new, :create]
  before_action :require_current_user, only: [:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def index
  end

  def edit
    
  end

  def update
    if current_user.update(user_params) 
      flash[:success] = "Your Danebook profile has been updated"
      redirect_to user_profiles_path(current_user) 
    else
      flash.now[:failure] = "Failed to update your Danebook profile"
      redirect_to user_profiles_path(current_user) 
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      flash[:success] = "Welcome to Danebook!"
      redirect_to user_profiles_path(current_user)
    else
      flash.now[:error] = "Something went wrong and your account was not saved."
      render :new
    end
  end

  def destroy
  end

  def show
  end

  private

    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation, 
        profile_attributes: [:about_me, :words_to_live_by, :telephone, :current_location, :hometown, :college, :id])
    end

    def set_user
      @user = current_user
    end
end
