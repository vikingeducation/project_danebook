class ActivitiesController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    @activity = Activity.new
    @user = User.find(params[:user_id])
    @activities = @user.activities.order(id: :desc)
  end

  def create
    @user = User.find(params[:user_id])
    type = params[:type].pluralize
    @user.send(type).create(activities_params)
    redirect_to user_activities_path(@user)
  end

  private

   def activities_params
     params.require(:activity).permit(:content)
   end


end
