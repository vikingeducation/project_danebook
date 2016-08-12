class ProfilesController < ApplicationController

  def show
    @user = User.find(params[:user_id])
  end

  def edit
    unless params[:id] == current_user.id.to_s
      flash[:error] = "You're not authorized to view this"
      redirect_to root_url
    @user = current_user
    end
  end


end
