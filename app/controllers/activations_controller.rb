class ActivationsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    token = params[:id]
    if user && !user.activated? && user.authenticated? :activation, token
      update_attribute(:activated, true)
      update_attribute(:activated_at, Time.zone.now)
      log_in user
      flash[:success] = 'Your account has been activated! Loggin you in now.'
      redirect_to user
    else
      flash[:danger] = 'Invalid activation link.'
      redirect_to root_url
    end
  end

end
