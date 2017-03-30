class UsersController < ApplicationController
  before_action :set_return_path, only: [:update]
  skip_before_action :require_login, :only => [:new, :create]


  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    @profile = @user.build_profile
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User has been created"
      sign_in(@user)
      redirect_to edit_user_profile_path(@user)
    else
      flash.now[:error] = "Unable to create user"
      render :new
    end

  end

  def update
    @user = current_user

    if @user.update(user_params)
      flash[:success] = "Photo updated."
    else
      flash[:error] = "Sorry, that didn't work."
    end
    redirect_to session.delete(:return_to)
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
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :cover_photo_id, :profile_photo_id, :profile_attributes => [:month, :day, :year, :gender, :user_id])
    end
end
