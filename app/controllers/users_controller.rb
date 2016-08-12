class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
    render 'static_pages/home'
  end

  def create
    @user = User.new(whitelisted_user_params)
    if @user.save
      sign_in(@user)
      flash[:success] = 'User created!'
      redirect_to timeline_path
    else
      flash[:error] = 'Something went wrong :('
      render 'static_pages/home'
    end
  end

  def edit
    @user = current_user
    @profile = @user.profile
    render 'static_pages/about_edit'
  end

  def update
    if current_user.update_attributes(whitelisted_user_params)
      flash[:success] = 'Successfully updated your profile!'
      redirect_to current_user
    else
      flash.now[:failure] = 'Failed to update your profile'
      redirect_to root_url
    end
  end

  def show
    @user = params[:id] ? User.find(params[:id]) : User.first
    @profile = @user.profile
    render 'static_pages/about'
  end

  def destroy
  end



  private

  def whitelisted_user_params
    params.require(:user).permit(:id, :email,
      :password, :password_confirmation,
      :profile_attributes => [ :id, :birthday,
        :college,
        :hometown, :currently_lives, :telephone,
        :words_to_live_by, :about_me])
  end
end
