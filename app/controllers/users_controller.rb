class UsersController < ApplicationController

  
  before_action :require_login, :except => [:new, :create]
  before_action :require_current_user, :only => [:edit, :update, :destroy]

  def index
    @post = Post.new
  end


  def new
    @user = User.new
  end

  def create
    @user = User.new(params_hash)

    if @user.save
      sign_in(@user)
      flash[:success] = "Successfully created a user"
      redirect_to user_path(@user)
    else
      flash[:error] = "Could not create new user"
      render :new
    end
  end

  def show
    if params[:id]
      redirect_to user_profiles_path(params[:id])
    else
      redirect_to user_profiles_path(current_user)
    end
  end

  

  def edit
  end

  def update
    user = current_user
    if user.update(params_hash)
      flash[:success] = "Successfully updated your profile"
      # fail
      redirect_to user_path(current_user)
    else
      # fail
      flash.now[:error] = "Failed to update profile"
      render :edit
    end
  end

  def destroy
  end

  private

    def params_hash
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :dob, :gender, :college_name, :hometown, :current_home, :telephone, :words_live_by, :about_me)
    end
end
