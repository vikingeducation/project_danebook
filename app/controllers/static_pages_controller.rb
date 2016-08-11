class StaticPagesController < ApplicationController
  before_action :set_user, :except => [:new, :create]

  def home

  end

  def timeline
  end

  def about
    unless @user.profile
      @user.create_profile   # question is it better to have this be a build instead of create here?????
      redirect_to user_about_edit_path(@user)
    end
  end

  def about_edit
  end

  private
    def whitelisted_user_params
      params.
        require(:user).
        permit( :first_name,
                :last_name,
                :email,
                :password,
                :password_confirmation,
                :birth_date)
    end

end
