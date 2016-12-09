class UsersController < ApplicationController

  before_action :require_login, :except => [:new, :create]
  skip_before_action :require_login, :only => [:new, :create]

  def index

  end

  def show
    @user = User.find(params[:id])
  end

  def new
    if signed_in_user?
      @user = current_user
      redirect_to @user
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(whitelisted_params)
    if @user.save
      sign_in(@user)
      flash[:success] = "Welcome"
      redirect_to @user
    else
      flash[:error] = "Try again"
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(whitelisted_params)
      flash[:success] = "Profile successfully updated"
      redirect_to @user
    else
      flash[:error] = "Oops! Something didn't save correctly. Please try again."
      render :edit
    end
  end

  def destroy

  end

  private

  def whitelisted_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :email,
                                 :password,
                                 :password_confirmation,
                                 :birth_month,
                                 :birth_day,
                                 :birth_year,
                                 :gender,
                                 :college,
                                 :hometown,
                                 :current_town,
                                 :phone,
                                 :words_to_live_by,
                                 :about_me)
  end



end
