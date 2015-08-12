class UsersController < ApplicationController

  before_action :require_login, :except => [:new, :create]
  before_action :require_current_user, :only => [:edit, :update, :destroy]

  def index
    @users=User.all
  end

  def new
    @user=User.new
  end

  def friends
    @user=User.find(params[:id])
    @friends=@user.friends
    render :friends
    #redirect_to user_friends_path(@user, @friends)


  end

  def create
    @user=User.create(whitelisted_user_params)
    if @user.persisted?
      sign_in(@user)
      flash[:success]="You created a new account"
      redirect_to user_profile_path(:id => @user.id, :user_id => @user.id)
    else
      flash.now[:error]="Unable to create account"
      render :new
    end
  end

  def show
    @user=User.find(params[:id])
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    if current_user.update(whitelisted_user_params)
      flash[:success] = "Profile updated"
      redirect_to users_path
    else
      flash.now[:error]="Unable to update account"
      render :edit
    end
  end

  def destroy
    sign_out
    flash[:success]="Signed out"
    redirect_to login_path
  end

  private

  def whitelisted_user_params
    params.require(:user).permit( :id, 
                                  :username,
                                  :email,
                                  :password,
                                  :password_confirmation,
                                  :first_name,
                                  :last_name,
                                  :birthday,
                                  :gender)
  end
end
