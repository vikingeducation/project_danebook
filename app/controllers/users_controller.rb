class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :require_current_user, only: [:edit, :update, :destroy]


  def new
    @user = User.new
    @profile = @user.profile.build
  end

  def create
    @user = User.new(user_params)
    if @user.save!
      sign_in(@user)
      flash[:success] = "Your account has been created"
      redirect_to timeline_path
    else
      flash[:error] = "Account could not be created"
      redirect_to root_path
    end
  end


  private

  def user_params
    params.require(:user).permit(:email,
                                 :password,
                                 :password_confirmation,
                                 {:profile_attributes => [
                                  :first_name,
                                  :last_name,
                                  :birthday,
                                  :gender
                                  ]})
  end

end
