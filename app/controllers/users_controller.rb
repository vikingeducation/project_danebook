class UsersController < ApplicationController
  before_action :require_login, except: [:index, :new, :create, :show]
  before_action :require_current_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(whitelisted_params)
    if @user.save
      sign_in(@user)
      flash[:success] = "User Created"
      redirect_to user_path(@user)
    else
      flash.now[:danger] = "Something went wrong"
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    params[:user][:profile_attributes][:user_id] = current_user.id
    if current_user.update(whitelisted_params)
      flash[:success] = "You succesfully updated your profile"
      redirect_to user_path(current_user)
    else
      flash.now[:danger] = "Something went wrong"
      render :edit
    end
  end

  def timeline
    @user = User.find(params[:id])
  end

  private

  def whitelisted_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 profile_attributes: [:id, :user_id, :first_name, :last_name, 
                                                      :birth_month, :birth_day, :birth_year,
                                                      :gender, :college, :hometown, :current_address, 
                                                      :phone, :my_words, :about_me])
  end
end
