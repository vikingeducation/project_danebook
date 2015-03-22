class UsersController < ApplicationController
  before_action :require_current_user, :only => [:edit, :update, :destroy]
  before_action :set_user, :only => [:destroy, :edit, :update, :show ]

  def index
    @users = User.all
    @new_user = User.new
    @new_profile = @new_user.build_profile
    if @user && @user.authenticate(params[:password])
      sign_in(@user)
      flash[:success] = "Signed in successfully!"
      redirect_to friends_path # schwadtidy when architecture built
    else
      flash.now[:error] = "Please sign up or sign in"
      render :index
    end
  end

  def show

  end

  def new
    @user = User.new
  end

  def edit
    require_current_user
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save    
      sign_in(@user)
      flash[:success] = "created new user!"
      redirect_to @user
    else
      flash.now[:error] = "There was an error"
      redirect_to root_path
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Successfully updated"
      redirect_to @user
    else
      flash.now[:failure] = "failed to update"
      render :edit
    end
  end

  def destroy
    @user.destroy
    sign_out
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
    params.
      require(:user).
      permit(:email,
             :password,
             :password_confirmation,
             { :profile_attributes => [
              :user_id,
              :hometown,
              :college,
              :currenttown,
              :words,
              :aboutme,
              :telephone,
              :birthday] } )
  end
end



