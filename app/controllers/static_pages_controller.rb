class StaticPagesController < ApplicationController
  before_action :set_user, :except => [:new, :create]
  
  def home

  end

  def timeline
  end

  def about

    # unless current_user = User.find(params[:id])
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
