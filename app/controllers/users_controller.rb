class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(white_list_params)
    if @user.save
      flash[:success] = ["Sign Up success!"]
      redirect_to signup_path
    else
      flash[:danger] = @user.errors.full_messages
      render :new
    end
  end


  private
    def white_list_params
      params.require(:user).permit(:email,
                                   :password,
                                   :password_confirmation)
    end

end
