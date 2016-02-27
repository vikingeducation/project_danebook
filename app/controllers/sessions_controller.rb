class SessionsController < ApplicationController
  before_filter :store_referer

  def new
  end

 def create
   @user = User.find_by_email(params[:email])
   if @user # && @user.authenticate(params[:password])
     sign_in(@user)
     flash[:success] = "Signed in successfully!"
     redirect_to user_profile_path(@user.id)
   else 
     flash[:error] = "This combination was not found"
     redirect_to referer
   end
 end

 def destroy 
   sign_out
   flash[:success] = "Signed out successfully"
   redirect_to root_path
 end

end
