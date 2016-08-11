class UsersController < ApplicationController
  skip_before_action :require_login, only: [:create, :new]
  before_action :require_current_user, :only => [:edit, :update, :destroy]
  before_action :set_user, except: [ :create, :new ]
  before_action :require_current_user, except: [ :about, :create, :new ]

  def show
    # redirect_to user_about_path(@user) unless self_profile?
  end

  def new
    @user = User.new
    redirect_to user_path(current_user) if signed_in_user?
  end

  def create
    if signed_in_user?
      redirect_to timeline_path
    else
      @user = User.new(user_params)
      if @user.save
        sign_in(@user)
        # flash[:success] = "Created new user!"
        redirect_to user_path(@user)
      else
        flash[:danger] = "Please fill out all fields!"
        redirect_to root_path
      end
    end
  end

  def edit
    @cities = City.includes(:name, :country)
    @countries = @cities.map(&:country)
  end

  def update
    if current_user.update(user_params)
      # flash[:success] = "Successfully updated your profile"
      redirect_to current_user
    else
      flash.now[:danger] = "Failed to update your profile"
      render :edit
    end
  end

  def about

  end

  private

  def user_params
    params.
      require(:user).
      permit( :first_name,
              :last_name,
              :email,
              :password,
              :password_confirmation,
              :birth_date,
              :gender)
  end

  def set_user
    @user = User.find(params[:id])
  end


end
