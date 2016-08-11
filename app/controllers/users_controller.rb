class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(whitelisted_user_params)
    if @user.save
      sign_in(@user)
      flash[:success] = "User was saved in database"
      redirect_to @user
    else
      flash[:error] = "User was NOT! saved in database"
      render :new
    end
  end

  def edit
  end

  def update
    #tobewritten
  end

  def destroy
    #tobewritten
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def whitelisted_user_params
      params.
        require(:user).
        permit( :username,
                :email,
                :password,
                :password_confirmation)
    end
end
