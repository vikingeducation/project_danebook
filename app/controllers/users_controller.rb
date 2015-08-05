class UsersController < ApplicationController

  # Require login to see content about a user
  before_action :require_login, :except => [:new, :create]

  # Only a user can see his/her own edit page, or delete his/her account
  before_action :require_current_user, :only => [:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      flash[:success] = "Welcome to Danebook #{@user.name}"
      redirect_to user_path(@user)
    else
      flash.now[:error] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.includes(:profile).find(params[:id])
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      flash[:success] = "Your profile was updated"
      redirect_to user_path(current_user)
    else
      flash.now[:error] = @user.errors.full_messages
      render :edit
    end
  end

  def destroy
    current_user.destroy
    sign_out
    flash[:success] = "Your account was successfully deleted from Danebook."
  end

  private

  def user_params
    params.require(:user).permit(
        :first_name,
        :last_name,
        :email,
        :password,
        :password_confirmation,
        :birthday,
        :gender,
        { profile_attributes: [
            :college,
            :hometown,
            :current_home,
            :mobile,
            :summary,
            :about
            ]
          })
  end


end
