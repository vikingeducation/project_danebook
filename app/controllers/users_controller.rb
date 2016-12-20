class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  before_action :require_current_user, only: [:edit, :update, :destroy]


  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    redirect_to user_profile_url @user
  end

  def new
    if signed_in_user?
      redirect_to user_timeline_path current_user
    else
      @user = User.new
      @user.build_profile
    end
  end

  def create
    @user = User.new(whitelisted_params)
    if @user.save
      #welcome email
      # User.send_welcome_email(@user.id)
      sign_in(@user)
      flash[:success] = "Welcome"
      redirect_to edit_user_profile_path(current_user)
    else
      flash[:error] = "Try again"
      render :new
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def whitelisted_params
    params.require(:user).permit(:email,
                                 :password,
                                 :password_confirmation,
                                 { profile_attributes: [:birthday,
                                   :gender,
                                   :first_name,
                                   :last_name]}
                                 )
  end

end
