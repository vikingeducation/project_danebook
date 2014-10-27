class UsersController < ApplicationController

  before_action :require_login, only: [:show, :edit, :update, :destroy]

  def new
    current_user ? redirect_to current_user : @user = User.new
  end

  def create
    @user = User.new(whitelisted_params)
    if @user.save!
      sign_in(@user)
      flash[:success] = "Welcome to Danebook"
      redirect_to @user
    else
      flash[:error] = "That didn't work, try again"
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    redirect_to user_timeline_path(@user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
   if @user.update(user_params)
      flash[:success] = "#{@user.first_name} #{@user.last_name} has been updated"
      redirect_to current_user
    else
      flash.now[:error] = "Update failed. What have you done?"
      render :edit
    end
  end

  private

  def whitelisted_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :gender, :month, :year, :day, :words_to_live_by, :phone, :town, :college, :about_me :hometown
  end
end
