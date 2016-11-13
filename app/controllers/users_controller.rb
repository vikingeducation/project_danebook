class UsersController < ApplicationController
  before_action :require_current_user, :only => [:edit, :update, :destroy]
  before_action :require_login, :except => [:new, :create, :index]


  def index
    @users = User.all
  end

  def show
    @user = current_user
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User has been created"
      sign_in(@user)
      redirect_to user_path(current_user)
    else
      flash.now[:error] = "Unable to create user"
      render :new
    end

  end

  def update
    respond_to do |format|
      if current_user.update(user_params)
        format.html { redirect_to current_user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    current_user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation, :first_name, :last_name, :gender, :birthday)
    end
end
