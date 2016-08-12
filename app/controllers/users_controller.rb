class UsersController < ApplicationController
  
  # Whitelist
  skip_before_action :logged_in_user, except: [:edit, :update, :index, :destroy]
  skip_before_action :correct_user, except: [:edit, :update, :destroy]
  before_action :set_user, except: [:index, :new, :create]


  def index
    #will_paginate requires an instance variable.
    @users = User.search(params[:search], params[:page], current_user)
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
    @profile = @user.profile
    @cities = City.all
    @states = State.all
    @countries = Country.all
  end

  def update
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
    @profile = @user.profile
    @microposts = @user.microposts.paginate(page: params[:page], per_page: 4)
  end

  def destroy
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

    # Setting a user before specific actions.
    def set_user
      case action_name
      when 'show'
        @user = User.find_by_id(params[:id])
      when 'edit', 'update', 'destroy'
        @user = current_user
      end
      redirect_to_referer root_path, :flash => {:error => 'Unable to find that user'} unless @user
    end
    
end
