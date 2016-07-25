class UsersController < ApplicationController
  #Authorization.
  before_action :logged_in_user, only: [:edit, :update, :index]
  before_action :correct_user, only: [:edit, :update]


  def index
    #will_paginate requires an instance variable.
    @users = User.search(params[:search], params[:page])
    render 'static_pages/all_users', 
            locals: { users: @users }
  end

  def new
    user = User.new
    render 'static_pages/signup', 
           locals: { user: user }
  end

  def create
    user = User.new(user_params)
    if user.save
      user.send_activation_email
      flash[:info] = 'You have been sent an email containing a link to activate your account.'
      redirect_to root_url
    else
      flash[:danger] = 'Invalid information. Please try again to sign up.'
      render 'static_pages/signup'
    end
  end

  def edit
    user = User.find(params[:id])
    render 'static_pages/about', 
           locals: { user: user }, 
           action: :edit
  end

  def update
    user = User.find(params[:id])
    if user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to user
    else
    render 'static_pages/about', 
           locals: { user: user }, 
           action: :edit
    end
  end

  def show
    user = User.find(params[:id])
    render 'static_pages/about', 
            locals: { user: user },
            action: :show
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path
  end

  private
    def user_params
      permissible_params = [:first_name,
                               :last_name,
                               :email,
                               :password, 
                               :password_confirmation]
      params.require(:user).permit(permissible_params)
    end

    def logged_in_user
      redirect_to login_path if !logged_in?
    end

    def correct_user
      user = User.find(params[:id])
      redirect_to root_url unless current_user == user
    end

end
