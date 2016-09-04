class UsersController < ApplicationController
  before_action :require_current_user, :only => [:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(white_list_params)
    if @user.save
      permanent_sign_in(@user)
      flash[:success] = ["Sign Up success!"]
      redirect_to signup_path
    else
      flash[:danger] = @user.errors.full_messages
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if current_user.update(white_list_params)
      flash[:success] = ["Profile has been successfully updated"]
      redirect_to user_path(current_user)
    else
      flash.now[:danger] = current_user.errors.full_messages
      render :edit
    end
  end


  private
    def white_list_params
      params.require(:user).permit(:email,
                                   :birthday,
                                   :college,
                                   :home_town,
                                   :current_lives,
                                   :telephone,
                                   :words_to_live_by,
                                   :about,
                                   :password,
                                   :password_confirmation)
    end

end
