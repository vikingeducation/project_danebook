class UsersController < ApplicationController

  def new
    @user = User.new
    @user.profiles.build
    # redirect_to current_user if current_user
  end

  def create
    @user = User.new(whitelisted_user_params)
    if @user.save
      sign_in(@user)
      flash[:success]="Your account was successfully created!"
      redirect_to root_path
    else
      flash[:error]="We couldn't create your account."
      redirect_to root_path#currently blank page
    end
  end

  def show
  end

  private

  def whitelisted_user_params
    params.require(:user).permit( :first_name, :last_name, :email,
                                  :password, :password_confirmation,
                                  { :profile_attributes => [:birthdate, :id] })
  end

  # def change_birthdate_to_i
  #   params[:user][:birth_month] = params[:user][:birth_month].to_i
  #   params[:user][:birth_day] = params[:user][:birth_day].to_i
  #   params[:user][:birth_year] = params[:user][:birth_year].to_i
  # end
end
