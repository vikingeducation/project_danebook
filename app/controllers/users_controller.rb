class UsersController < ApplicationController

  before_action :set_user, except: [:new, :create]
  before_action :require_login, except: [:new, :create]

  def new
    @user = User.new
    @profile = @user.build_profile
  end


  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      flash[:success] = "Created New User Successfully!"
      redirect_to user_timeline_path(@user)
    else
      flash[:error] = "Unable to Create New User"
      render :new
    end
  end


  def edit
  end


  def update
  end


  def show
  end


  def destroy
  end

private


  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, { profile_attributes: [ :last_name, :first_name, :birthday, :gender] })
  end

end
