class SessionController < ApplicationController
  skip_before_action :require_login, :only => [:create]

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      if params[:remember_me] 
        permanent_sign_in(@user)
      else
        sign_in(@user)
      end
      flash[:success] = "You've successfully signed in! Our apes are shrieking with joy to witness once again your gorgeous visage."
      redirect_to posts_path
    else
      flash[:error] = "We couldn't sign you in. Make sure you entered a valid e-mail/password combo. Dingus."
      redirect_to new_user_path
    end
  end

  def destroy
    sign_out
    flash[:success] = "Goodbye! Farewell! Until we meet again!"
    redirect_to new_user_path
  end

end
