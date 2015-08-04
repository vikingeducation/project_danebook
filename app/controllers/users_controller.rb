class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(whitelisted_user_params)
    # dhsk
    if @user.save
      sign_in(@user)
      flash[:success] = "Congrats! You are a member now!"
      redirect_to signin_path
    else
      flash[:error] = "Error. Please try again!"
      render signin_path
    end
  end


  private 

  def whitelisted_user_params
    user_params = params.require(:user).permit(:email,
                                               :password, 
                                               :password_confirmation,
                                               :profile_attributes => [ 
                                                  :first_name,
                                                  :last_name,
                                                  "birthday_year(1i)",
                                                  "birthday_year(2i)",
                                                  "birthday_year(3i)",
                                                  :gender
                                                ])
    user_params[:profile_attributes][:birthday_year] = user_params[:profile_attributes]["birthday_year(1i)"]
    user_params[:profile_attributes].delete("birthday_year(1i)")
    user_params[:profile_attributes][:birthday_month] = user_params[:profile_attributes]["birthday_year(2i)"]
    user_params[:profile_attributes].delete("birthday_year(2i)")
    user_params[:profile_attributes][:birthday_day] = user_params[:profile_attributes]["birthday_year(3i)"]
    user_params[:profile_attributes].delete("birthday_year(3i)")

    user_params
  end
end












