class UsersController < ApplicationController
  skip_before_action :require_login, :only => [:new, :create]
  before_action :require_authorized_user, :only => [:edit, :update, :destroy]

  def new
    @user = User.new
    #@user.build_profile
    render "static_pages/home"
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      sign_in(@user)
      flash[:success] = "Created new user!"
      redirect_to user_path(@user)
    else
      render "static_pages/home"
    end
  end

  #about page
  def show
    @user = User.find(params[:id])
    @profile = @user.profile
  end

  def edit
    @user = User.find(params[:id])
    @profile = @user.profile
  end

  def update
    @user = User.find(params[:id])
     if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def friends
    @user = User.find(params[:id])
    @profile = @user.profile
  end

  private

  def user_params
    params.require(:user).permit(:email,:password, :password_confirmation, :profile_attributes=>[:first_name, :last_name, :birthday, :gender, :college, :hometown, :currently_lives, :telephone, :words_to_live_by, :about_me])
  end

end
