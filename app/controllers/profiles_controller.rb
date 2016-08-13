class ProfilesController < ApplicationController
  before_action :require_current_user, only: [:edit]
  before_action :set_user, only: [:show, :edit]
    
  def edit
    #HAD TO HARD CODE THIS IN, OTHER WISE PEOPLE CAN EDIT ANYONE
    redirect_to "http://nouveller.com/404/" if @user != current_user
    @profile = current_user.profile
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
