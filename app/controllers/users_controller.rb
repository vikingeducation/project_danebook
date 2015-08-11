class UsersController < ApplicationController

  # Require login to see content about a user
  before_action :require_login, :except => [:new, :create]

  # Sets @user so shared views don't break
  before_action :set_user, :only => [:edit, :update]

  # Only a user can see his/her own edit page, or delete his/her account
  before_action :require_current_user, :only => [:edit, :update, :destroy]

  def new
    if cookies[:auth_token]
      flash[:success] = "Welcome back #{current_user.name}!"
      redirect_to user_timeline_path(current_user)
    end
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      flash[:success] = "Welcome to Danebook #{@user.name}!"
      redirect_to user_path(@user)
    else
      str = ""
      @user.errors.full_messages.each do |message|
        str += "<li>#{message}</li>"
      end
      flash.now[:error] = str.html_safe
      #  flash.now[:error] = @user.errors.full_messages.join(', ')
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
      flash.now[:error] = current_user.errors.full_messages
      render :edit
    end
  end

  def destroy
    current_user.destroy
    sign_out
    flash[:success] = "Your account was successfully deleted from Danebook. Sad to see you leave!"
    redirect_to root_path
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
        :gender)
  end

  def set_user
    @user = current_user
  end

end
