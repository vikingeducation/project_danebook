class UsersController < ApplicationController
  
  # Whitelist
  skip_before_action :logged_in_user, except: [:edit, :update, :index]
  skip_before_action :correct_user, except: [:edit, :update]


  def index
    #will_paginate requires an instance variable.
    @users = User.search(params[:search], params[:page])
  end

  def new
    @user = User.new
    @profile = @user.profile
  end

  def create
    @user = User.new({ email: user_params[:email],                
                       password: user_params[:password] })
    if @user.save && @user.create_profile!(first_name: user_params[:first_name], 
                                           last_name: user_params[:last_name])
      @user.send_activation_email
      flash[:info] = 'You have been sent an email containing a link to activate your account.'
      redirect_to root_url
    else
      flash[:danger] = 'Invalid information. Please try again to sign up.'
      redirect_to new_user_path
    end
  end

  def edit
    @user = User.find(params[:id])
    @profile = @user.profile
    @cities = City.all
    @states = State.all
    @countries = Country.all
  end

  def update
    @user = User.find(params[:id])
    @profile = @user.profile
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      flash[:danger] = "Could not update profile!"
      redirect_to edit_user_path(@user)
    end
  end

  def show
    @user = User.find(params[:id])
    @profile = @user.profile
    @microposts = @user.microposts.paginate(page: params[:page], per_page: 4)
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:success] = Account has been deleted.
    redirect_to root_path
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
    
end
