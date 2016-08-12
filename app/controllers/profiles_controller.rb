class ProfilesController < ApplicationController
    before_action :require_current_user, only: [:edit, :update, :destroy]
  def edit
    @user = current_user
    @profile = @user.profile
  end

  def update
  end

  def show
    @user = current_user
    @profile = @user.profile
  end

  def destroy
  end

  def index

  end
end
