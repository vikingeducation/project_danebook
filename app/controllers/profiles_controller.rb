class ProfilesController < ApplicationController
  def edit
  end

  def update
  end

  def show
    @user = User.find(params[:user_id])
    @profile = @user.profile
  end

  def destroy
  end

  def index
    render :show
  end
end
