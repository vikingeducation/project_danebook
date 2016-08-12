class StaticPagesController < ApplicationController
  before_action :set_user, :except => [:new, :create]

  def home

  end

  def timeline
  end

  def about
  end

  def about_edit
  end

  private

    def set_user
      @user = User.find(params[:user_id])
    end

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

    # def white_listed

end
