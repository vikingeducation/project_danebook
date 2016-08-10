class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(whitelisted_user_params)
    if @user.save
      flash[:notice] = "User was saved in database"
      redirect_to @user
    else
      flash[:error] = "User was NOT! saved in database"
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
    def whitelisted_user_params
      params.
        require(:user).
        permit( :name,
                :email,
                :password,
                :password_confirmation)
    end
end
