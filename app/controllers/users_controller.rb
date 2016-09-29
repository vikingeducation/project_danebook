class UsersController < ApplicationController
  skip_before_action :require_login, :only => [:new, :create, :show]

  def new
    if signed_in_user?
      redirect_to user_path(current_user)
    else
      @user = User.new
    end
  end

  def show

  end

  def create
    @user = User.new(user_params)
    if @user.save
      permanent_sign_in(@user)
      flash[:success] = "You've successfully signed up"
      redirect_to user_path(@user)
    else
      flash.now[:danger] = "Please correct errors and resubmit the form"
      render :new
    end
  end



  private

  def user_params
      params.require(:user).permit(:first_name, :last_name, :email,
                                   :password, :password_confirmation,
                                   :birthday, :gender_cd)
  end


end
