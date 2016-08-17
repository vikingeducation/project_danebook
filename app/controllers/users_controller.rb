class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Created new user!"
      sign_in(@user) 
      redirect_to user_about_path(@user)
    else
      flash[:error] = @user.errors.full_messages.first
      @home = true
      render 'static_pages/home'
    end
  end

  def user_params
    params.require(:user).permit(:id, :email, :password, :password_confirmation, :first_name, :last_name, :gender, :profile_attributes => [:birth_date])
  end
end
