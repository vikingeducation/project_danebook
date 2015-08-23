class UsersController < ApplicationController

  skip_before_action :require_signin
  skip_before_action :require_current_user

  def index
    @users = User.search_user_by(params[:keyword])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(whitelisted_user_params)
    if @user.save
      sign_in(@user)
      flash[:success] = "Congrats! You are a member now!"
      redirect_to edit_profile_path(@user.profile.id)
    else
      flash.now[:error] = "Error. Please try again!"
      render "sessions/new"
    end
  end

  def set_profile_photo
    session[:return_to] ||= request.referer
    current_user.profile_photo = Photo.find(params[:photo_id])
    if current_user.save
      flash[:success] = "Your profile photo has successfully set!"
    else
      flash[:error] = "Error! Try again!"
    end
    redirect_to session.delete(:return_to)
  end

  def set_cover_photo
    session[:return_to] ||= request.referer
    current_user.cover_photo = Photo.find(params[:photo_id])
    if current_user.save
      flash[:success] = "Your cover photo has successfully set!"
    else
      flash[:error] = "Error! Try again!"
    end
    redirect_to session.delete(:return_to)
  end


  private 

  def whitelisted_user_params
    user_params = params.require(:user).permit(:email,
                                               :password, 
                                               :password_confirmation,
                                               :profile_attributes => [ 
                                                  :first_name,
                                                  :last_name,
                                                  :birthday,
                                                  :gender
                                                ])
  end
end












