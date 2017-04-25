class ProfilesController < ApplicationController
  def edit
    @user = User.find(params[:user_id])
  end


  def update
    @user = User.find(params[:user_id])

    if @user.update_attributes(profile_params)
      flash[:success] = "You profile has been updated"
      redirect_to user_about_path(@user)
    else
      flash[:error] = "Update fail"
      render :edit
    end
  end

  def profile_params
    params.require(:user).permit(profile_attributes: [:id, :college, :hometown, :current_city, :telephone, :about, :quote])
  end

end
