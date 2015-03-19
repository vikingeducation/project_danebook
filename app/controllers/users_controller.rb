class UsersController < ApplicationController
  before_action :require_current_user, :only => [:edit, :update, :destroy]
  before_action :set_user, :only => [:destroy, :edit, :update, :show ]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      flash[:success] = "created new user!"
      redirect_to @user
    else
      flash.now[:error] = "There was an error"
      redirect_to root_path
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        flash[:success] = "Successfully updated"
        redirect_to @user
      else
        flash.now[:failure] = "failed to update"
        render :edit
      end
    end
  end

  def destroy
    @user.destroy
    sign_out
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.
      require(:user).
      permit(:username,
             :email,
             :password,
             :password_confirmation
             )
  end
end



end
