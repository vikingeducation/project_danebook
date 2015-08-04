class UsersController < ApplicationController

  before_action :require_login, :except => [:new, :create]
  before_action :require_current_user, :only => [:edit, :update, :destroy]

  def new
    @user = User.new
    @user.build_profile
    redirect_to current_user if current_user
  end

  def create
    @user = User.new(whitelisted_user_params)
    # fail
    if @user.save
      # @user.profile.save
      sign_in(@user)
      flash[:success]="Your account was successfully created!"
      redirect_to edit_user_profile_path(@user)
    else
      flash.now[:error]="We couldn't create your account."
      render :new
    end
  end

  def edit
    current_user
    # @profile = current_user.profile
  end

  def update
    if current_user.update(whitelisted_user_params)
      flash[:success] = "Successfully updated your profile"
      redirect_to current_user
    else
      flash.now[:failure] = "Failed to update your profile"
      render :edit
    end
  end

  def show
    current_user
    @profile = current_user.profile
  end

  # def destroy
  #   sign_out
  #   redirect_to root_path
  # end

  private

  def whitelisted_user_params
    params.require(:user).permit( :first_name, :last_name, :email,
                                  :password, :password_confirmation,
                                  :birthdate,
                                { :profile_attributes =>
                                [ :id, :phone, :motto,
                                  :about, :college, :hometown,
                                  :location, :gender] })
  end


end
