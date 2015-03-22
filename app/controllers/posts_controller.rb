class PostsController < ApplicationController
  before_action :require_current_user, :only => [:edit, :update, :destroy]
  before_action :set_user, :only => [:destroy, :edit, :update, :show ]

  def index
    @users = User.all
    if @user && @user.authenticate(params[:password])
      sign_in(@user)
    else
      flash.now[:error] = "Please sign up or sign in"
      render :index
    end
  end

  def show

  end

  def new
    @user = current_user
    @new_post = @user.build_post
    jfkdl;sa
  end

  def edit
    require_current_user
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save    
      sign_in(@user)
      flash[:success] = "created new user!"
      redirect_to profiles_path(current_user.id)
    else
      flash.now[:error] = "There was an error"
      redirect_to profiles_path(current_user.id)
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Successfully updated"
      redirect_to @user
    else
      flash.now[:failure] = "failed to update"
      render :edit
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
      permit(:email,
             :password,
             :password_confirmation,
             { :profile_attributes => [
              :user_id,
              :hometown,
              :college,
              :currenttown,
              :words,
              :aboutme,
              :telephone,
              :birthday] },
              { :posts_attributes => [
                :content,
                :user_id ] } )
  end
end
