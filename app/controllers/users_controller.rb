class UsersController < ApplicationController
  skip_before_action :require_login, only: [:create]
  before_action :require_current_user, :only => [:edit, :update, :destroy]



  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      flash[:success] = "Created new user!"
      redirect_to timeline_path
    else
      flash.now[:error] = "Failed to Create User!"
      render :new
    end
  end

  def update
    if current_user.update(user_params)
      flash[:success] = "Successfully updated your profile"
      redirect_to current_user
    else
      flash.now[:failure] = "Failed to update your profile"
      render :edit
    end
  end

  private

  def user_params
    params.
      require(:user).
      permit( :first_name,
              :last_name,
              :email,
              :password,
              :password_confirmation)
  end


end
