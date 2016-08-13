class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
    @user.profile = Profile.new
    render 'static_pages/home'
  end

  def create
    @user = User.new(whitelisted_user_params)
    if @user.save
      sign_in(@user)
      flash[:success] = 'User created!'
      redirect_to user_timeline_path(@user)
    else
      flash[:error] = 'Something went wrong :('
      render 'static_pages/home'
    end
  end

  def edit
    # raise
    id = params[:user_id] ? params[:user_id] : params[:id]
    if id == current_user.id.to_s
      @user = current_user
      @profile = @user.profile
      render 'static_pages/about_edit'
    else
      flash[:error] = 'Unable to do that'
      redirect_to current_user
    end
  end

  def update
    if current_user.update_attributes(whitelisted_user_params)
      flash[:success] = 'Successfully updated your profile!'
      redirect_to current_user
    else
      flash.now[:error] = 'Failed to update your profile'
      redirect_to root_url
    end
  end

  def show
    # raise
    id = params[:user_id] ? params[:user_id] : params[:id]
    @user = id ? User.find(id) : User.first
    @profile = @user.profile
    render 'static_pages/about'
  end

  def destroy
  end





  private

  def whitelisted_user_params
    params.require(:user).permit(:id, :email,
      :password, :password_confirmation,
      :profile_attributes => [ :id,
        :first_name,
        :last_name,
        :birthday,
        :college,
        :hometown, :currently_lives, :telephone,
        :words_to_live_by, :about_me])
  end
end
