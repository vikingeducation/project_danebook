class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @profile = @user.profile
  end

  def create
    @user = User.new(whitelisted_params)
    if @user.save
      sign_in(@user)
      flash[:success] = "User Created"
      redirect_to user_path(@user)
    else
      flash.now[:danger] = "Something went wrong"
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    params[:user][:profile_attributes][:user_id] = params[:id]
    if current_user.update(whitelisted_params)
      flash[:success] = "You succesfully updated your profile"
      redirect_to user_path(current_user)
    else
      flash.now[:danger] = "Something went wrong"
      render :edit
    end
  end

  private

  def whitelisted_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 profile_attributes: [:id, :user_id, :first_name, :last_name, 
                                                      :birth_month, :birth_day, :birth_year,
                                                      :gender, :college, :hometown, :current_address, 
                                                      :phone, :my_words, :about_me])
  end
end
