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
      flash[:error] = "Error. Please try again!"
      redirect_to root_path
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
                                                  "birthday_year(1i)",
                                                  "birthday_year(2i)",
                                                  "birthday_year(3i)",
                                                  :gender
                                                ])
    user_params[:profile_attributes][:birthday_year] = user_params[:profile_attributes]["birthday_year(1i)"]
    user_params[:profile_attributes].delete("birthday_year(1i)")
    user_params[:profile_attributes][:birthday_month] = user_params[:profile_attributes]["birthday_year(2i)"]
    user_params[:profile_attributes].delete("birthday_year(2i)")
    user_params[:profile_attributes][:birthday_day] = user_params[:profile_attributes]["birthday_year(3i)"]
    user_params[:profile_attributes].delete("birthday_year(3i)")

    user_params
  end
end












