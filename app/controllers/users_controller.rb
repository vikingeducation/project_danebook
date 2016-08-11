class UsersController < ApplicationController
  #ADD UNIQUE CONSTRAINT TO USER EMAIL
  #ADD VALIDATIONS FOR USER ATTRIBUTES
  #UPDATE FORM TO RAILS FIELDS
  skip_before_action :require_login, :only => [:new, :create]
  before_action :require_current_user, :only => [:edit, :update, :destroy]

  def index
    redirect_to :timeline
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      flash[:success] = "User has been created!"
      redirect_to :timeline
    else
      flash.now[:warning] = @user.errors.full_messages
      render "static_pages/home"
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation,
                                  :birth_day, :birth_month, :birth_year,
                                  :gender, :first_name, :last_name)
    end

end
