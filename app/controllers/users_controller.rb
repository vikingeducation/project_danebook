class UsersController < ApplicationController
  #Authorization.
  before_action :logged_in_user, only: [:edit, :update, :index]
  before_action :correct_user, only: [:edit, :update]


  def index
    @users = User.search(params[:search], params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(permitUserParams)
    if @user.save
      flash[:success] = 'You have successfully signed up!'
      redirect_to login_path
    else
      flash[:danger] = 'Invalid information. Please try again to sign up.'
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(permitUserParams)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  private
    def permitUserParams
      permissibleUserParams = [:first_name,
                               :last_name,
                               :email,
                               :password, 
                               :password_confirmation]
      params.require(:user).permit(permissibleUserParams)
    end

    def logged_in_user
      redirect_to login_path if !logged_in?
    end

    def correct_user
      user = User.find(params[:id])
      redirect_to root_url unless current_user == user
    end

end
