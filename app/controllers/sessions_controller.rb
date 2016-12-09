class SessionsController < ApplicationController
  skip_before_action :authenticate, only: [:new, :create]

    def new
      create_session unless session[:user_id]
      if signed_in_user?
        redirect_to users_path
      end
    end

    def create
      @user = User.find_by_email(params[:email].downcase)
      if @user
        validate_credentials
      else
        flash.now[:danger] = ["Incorrect Credentials"]
        render :new
      end
    end

    def destroy
      sign_out
      flash[:success] = ["Signed Out"]
      redirect_to signup_path
    end

    def show
      redirect_to new_session_path
    end

    private

      def sessionizer
        @sessionizer ||= Sessionizer.new(@user, params)
      end

      def validate_credentials
        case sessionizer.validate_credentials
        when "locked"
          redirect_to root_path
        when "valid"
          sign_in(@user, params[:remember] == "true")
          redirect_to users_path
        else
          render :new
        end
      end

end
