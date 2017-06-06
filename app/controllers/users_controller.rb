class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    @user.build_profile
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      flash[:success] = "User created successfully"
      redirect_to root_path
    else
      @user.build_profile
      flash.now[:danger] = "Failed to create user"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
      :profile_attributes => [:id, :first_name, :last_name, :birthday, :gender]
    )
  end

end
