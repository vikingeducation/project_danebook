class ProfilesController < ApplicationController

  def update
    @user = current_user
    if @user.profile.update(whitelisted_params)
      flash[:success] = "Your \"About\" page was updated."
      redirect_to about_path
    else
      flash[:errors] = "We were not able to update your \"about\" page. Please see the following errors: #{@user.profile.errors.full_messages.join(', ')}"
      redirect_to about_edit_path
    end
  end


  def whitelisted_params
    params.require(:profile).permit(:college, :hometown, :currently_lives, :telephone, :life_words, :about_me, :birth_date)
  end
end
