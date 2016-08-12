class ProfilesController < ApplicationController
  before_action :set_profile, only: [:edit, :update]
  def edit
  end

  def update
  end

  def show
    @user = current_user
  end

  private

    def set_profile
      @profile = Profile.find(params[:id])
    end

end
