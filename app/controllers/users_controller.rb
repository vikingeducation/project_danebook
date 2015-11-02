class UsersController < ApplicationController
  before_action :require_login, :except => [:new, :create]
  before_action :require_current_user, :only => [:edit, :update, :destroy]
  before_action :set_user, :only => [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      if sign_in(@user)
        redirect_to @user, :flash => {:success => 'User created and signed in'}
      else
        redirect_to root_path, :flash => {:error => 'User created but unable to sign in'}
      end
    else
      flash.now[:error] = 'Unable to create user'
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, :flash => {:success => 'User updated'}
    else
      flash.now[:error] = 'Unable to update user'
      render :edit
    end
  end

  def destroy
    if sign_out
      if @user.destroy
        redirect_to rooth_path, :flash => {:success => 'User signed out and destroyed'}
      else
        redirect_to root_path, :flash => {:error => 'User signed out but unable to destroy'}
      end
    else
      flash[:error] = 'Unable to sign out'
      redirect_to request.referer
    end
  end


  private
  def set_user
    @user = User.exists?(params[:id]) ? User.find(params[:id]) : User.new
  end

  def user_params
    params.require(:user)
      .permit(
        :username,
        :email,
        :password,
        :password_confirmation,
        :first_name,
        :last_name,
        :birthday,
        :gender_id
      )
  end
end
