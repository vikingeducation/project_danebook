class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, except: [:index, :new, :create]

  skip_before_action :authenticate, only: [:new, :create]

  def index
    @users = User.all
  end

  def new
    @user = User.new
    @user.build_profile
  end

  def create
    @user = User.new(whitelisted)
    if @user.save
      sign_in(@user)
      flash[:success] = "Successfully signed in"
      redirect_to users_path
    else
      flash.now[:danger] = ["Something went wrong signing up"]
      @user.errors.full_messages.each do |error|
        flash.now[:danger] << error
      end
      render :new
    end
  end

  private

    def whitelisted
      if params[:user][:profile_attributes]["birthday(1i)"]
        params[:user][:profile_attributes][:birthday] = parse_date_select
      end
      params.require(:user).permit(
                                    :email,
                                    :password,
                                    :password_confirmation,
                                    {
                                      profile_attributes:[
                                                          :first,
                                                          :last,
                                                          :birthday,
                                                          :gender
                                                        ]
                                    }
                                  )
    end

    def parse_date_select
      Date.new params[:user][:profile_attributes]["birthday(1i)"].to_i, params[:user][:profile_attributes]["birthday(2i)"].to_i, params[:user][:profile_attributes]["birthday(3i)"].to_i
    end

    def correct_user
      unless params[:id] == current_user.id.to_s
        flash[:danger] = "You're not authorized to view this"
        redirect_to user_path(current_user)
      end
    end

    def set_user
      @user = User.find(params[:id])
    end

end
