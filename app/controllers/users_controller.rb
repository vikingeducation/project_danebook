class UsersController < ApplicationController
  skip_before_action :require_login, only: [:create, :new]

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      flash[:success] = "Created new user!"
      redirect_to @user
    else
      flash[:error] = "Failed to Create User!"
      redirect_to root_url
    end
  end

  def new
    redirect_to user_timeline_path(current_user) if signed_in_user?
    @user = User.new
    @user.build_profile
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
  end


  def timeline
  end

private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, profile_attributes: [:first_name, :last_name, :birthday, :about])
  end

end
