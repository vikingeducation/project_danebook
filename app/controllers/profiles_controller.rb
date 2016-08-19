class ProfilesController < ApplicationController
  before_action :require_current_user, only: [:edit]
  before_action :set_user, only: [:show, :edit]
    
  def edit
    if @user != current_user
      redirect_to "http://nouveller.com/404/" 
    else
      @profile = current_user.profile
      @photo = current_user.profile.photos.build
    end
  end

  def update
  end

  def show
    @profile = @user.profile
  end

  def destroy
  end

  def index
  end
end
