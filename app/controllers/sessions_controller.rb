class SessionsController < ApplicationController

  layout 'home_layout.html.erb'

  skip_before_action :require_signin, only: [:new, :create]
  # skip_before_action :require_current_user, only: [:new, :create]

  def new
    @user = User.new
    @user.build_profile
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      if params[:remember_me]
        permanent_sign_in(@user)
      else
        sign_in(@user)
      end
      flash[:success] = "Thanks for signing in!"
      redirect_to posts_path(user_id: current_user.id)
    else
      flash[:error] = "Error! We couldn't sign you in."
      redirect_to root_path
    end
  end

  def destroy
    session[:return_to] ||= request.referer
    if sign_out
      flash[:success] = "You have successfully signed out"
      redirect_to root_path
    else
      flash[:error] = "Angry robots have prevented you from signing out.  You're stuck here forever."
      redirect_to session.delete(:return_to)
    end
  end
  
end
