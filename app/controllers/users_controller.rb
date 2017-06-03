class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:new, :create, :show]
  layout :set_layout

  def index
    if params[:q]
      @term = params[:q].to_s
      @users = User.search(@term).includes(:profile)
    else
      @users = []
    end
  end

  def new
    @user = User.new
    @user.build_profile
    render layout: 'application'
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

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, profile_attributes: [:id, :sex, :'birthdate(1i)', :'birthdate(2i)', :'birthdate(3i)'])
  end

  def profile_params
    params.require(:user).permit(profile_attributes: [:id, :college, :hometown, :current_city, :telephone, :about, :quote])
  end

  private

  def set_layout
    case action_name
    when 'index'
      'application'
    else
      'single_column'
    end
  end


end
