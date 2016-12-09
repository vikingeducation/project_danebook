class ProfilesController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :correct_user, except: [:index, :show]

  def show
  end

  def edit
  end

  def update
    if @user.update(whitelisted)
      @user.profile.edited = true
      flash[:success] = ["Profile Successfully Edited"]
      redirect_to user_profile_path(@user)
    else
      flash.now[:danger] = ["Something went wrong.."]
      @user.errors.full_messages.each do |error|
        flash.now[:danger] << error
      end
      render :edit
    end
  end

  private

    def correct_user
      unless params[:user_id] == current_user.id.to_s
        flash[:danger] = ["You cannot mess with other users! Jerk.."]
        redirect_to user_profile_path(current_user)
      end
    end

    def set_user
      @user = User.find_by_id(params[:user_id])
      unless @user
        flash[:danger] = ["User does not exist"]
        redirect_to root_path
      end
    end
end
