class UsersController < ApplicationController

  before_action :require_login, except: [:new, :create]
  before_action :require_logout, only: [:new]
  before_action :require_current_user, only: [:edit, :update, :destroy]

  def index

  end

  def new
    @user = User.new
    @user.build_profile
  end

  def create
    @user = User.new(user_params)
    if @user.save(user_params)
      sign_in(@user)
      flash[:success] = "Created a new User!"
      redirect_to profile_path(@user)
    else
      flash.now[:danger] = "Failed to create User!"
      @user.build_profile
      render :new
    end
  end


  # def update
  #   if current_user.update(user_params)
  #     flash[:success] = "Successfully updated profile!"
  #     redirect_to profile_path(current_user)
  #   else
  #     flash.now[:danger] = "Failed to update your profile!"
  #     render :edit
  #   end
  # end

  # def destroy
  # end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      profile_attributes: [
        :gender,
        :birthday,
        :college,
        :from,
        :lives,
        :number,
        :words,
        :about
      ])
  end
end
