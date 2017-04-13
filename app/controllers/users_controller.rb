class UsersController < ApplicationController
  before_action :require_current_user, only: [:update, :destroy, :create, :edit]
  before_action :require_login, except: [:show, :new, :create]

  def new
    @user = User.new
    @user.build_profile
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Success! Welcome to Danebook, #{@user.first_name}"
      sign_in(@user)
      redirect_to user_about_path(@user)
    else
      flash[:error] = "We couldn't sign you up. Please check the form for errors"
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(profile_params)
      flash[:success] = "You profile has been updated"
      redirect_to user_about_path(@user)
    else
      flash[:error] = "Update fail"
      render :edit
    end
  end

  def show
    @user = User.find(params[:user_id])
  end


  private

  def user_params
    # TODO add birthdate
    params.require(:user).permit(:email, :password, :password_confirmation, profile_attributes: [:id, :sex, :first_name, :last_name, :'birthdate(1i)', :'birthdate(2i)', :'birthdate(3i)'])
  end

  def profile_params
    params.require(:user).permit(profile_attributes: [:id, :college, :hometown, :current_city, :telephone, :about, :quote])
  end


end
