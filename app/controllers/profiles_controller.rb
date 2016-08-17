class ProfilesController < ApplicationController

  def update
    @user = current_user
    if @user.profile.update(whitelisted_params)
      flash[:success] = "Your \"About\" page was updated."
      redirect_to user_about_path(@user)
    else
      flash[:errors] = "We were not able to update your \"about\" page. Please see the following errors: #{@user.profile.errors.full_messages.join(', ')}"
      redirect_to user_about_edit_path(@user)
    end
  end


  def whitelisted_params
    params.require(:profile).permit(:college, :hometown, :currently_lives, :telephone, :life_words, :about_me, :birth_date)
  end
end
